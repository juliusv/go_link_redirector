require 'spec_helper'

describe 'Link pages' do
  before(:all) { 50.times { FactoryGirl.create(:link) } }
  after(:all)  { Link.delete_all }

  subject { page }

  describe 'signed out' do
    describe 'new' do
      before { visit new_link_path }

      it { should have_link('Sign in with Google', href: '/auth/google_oauth2') }
      it { should_not have_content('New Link') }
    end

    describe 'follow link' do
      let(:link) { Link.find(1) }

      before { visit "/#{link.short_name}" }

      specify { current_url.should == 'http://www.example-1.org/' }
    end
  end

  describe 'signed in' do
    before { login_with_oauth }

    let(:short_name) { 'short_name' }
    let(:invalid_short_name) { 'short name' }
    let(:url) { 'http://www.example.org' }
    let(:comments) { 'example comments' }

    describe 'index' do
      before do
        visit links_path
      end

      it { should have_link('Sign out', href: signout_path) }
      it { should have_content('link_1') }
      it { should have_content('link_30') }
      it { should_not have_content('link_31') }
    end

    describe 'new' do
      before do
        visit new_link_path
        fill_in 'Short name', with: short_name
        fill_in 'Url', with: url
        fill_in 'Comments', with: comments
      end

      it { should have_selector('h1', text: 'New Link') }

      describe 'with valid args' do
        it 'should create a new link' do
          expect { click_button 'Create Link' }.to change(Link, :count).by(1)
        end
      end

      describe 'with invalid args' do
        before do
          fill_in 'Short name', with: invalid_short_name
        end

        it 'should not create a new link' do
          expect { click_button 'Create Link' }.not_to change(Link, :count)
        end
      end
    end

    describe 'edit' do
      let(:link) { FactoryGirl.create(:link) }

      before do
        visit edit_link_path(link.id)
        fill_in 'Short name', with: short_name
        fill_in 'Url', with: url
        fill_in 'Comments', with: comments
      end

      it { should have_selector('h1', text: 'Edit Link') }

      describe 'with valid args' do
        before { click_button 'Save Changes' }

        it { should have_selector('div.alert.alert-success') }
        specify { link.reload.short_name.should  == short_name }
        specify { link.reload.url.should  == url }
        specify { link.reload.comments.should  == comments }
      end

      describe 'with invalid args' do
        before do
          fill_in 'Short name', with: invalid_short_name
          click_button 'Save Changes'
        end

        it { should have_selector('div.alert.alert-error') }
        specify { link.reload.short_name.should_not == invalid_short_name }
      end
    end

    describe 'delete' do
      it 'should delete a link' do
        expect { click_link('Delete') }.to change(Link, :count).by(-1)
      end
    end
  end
end
