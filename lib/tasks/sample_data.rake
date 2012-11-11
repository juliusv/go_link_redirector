namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do
    50.times do |i|
      link = Link.new(short_name: "link_#{i}",
                      url: "http://www.url-#{i}.com",
                      owner_email: "tester@test.com",
                      comments: "Comment no. #{i}")
      link.last_change_email = link.owner_email
      link.save!
    end
  end
end
