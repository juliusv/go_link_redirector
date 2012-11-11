FactoryGirl.define do
  factory :link do
    sequence(:short_name)        { |n| "link_#{n}" }
    sequence(:url)               { |n| "http://www.example-#{n}.org" }
    sequence(:comments)          { |n| "Comments #{n}" }
    sequence(:owner_email)       { |n| "user#{n}@example.org" }
    sequence(:last_change_email) { |n| "user#{n}@example.org" }
  end
end
