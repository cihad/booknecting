FactoryGirl.define do  
  factory :user do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    username Faker::Internet.user_name
    email Faker::Internet.email
    password Faker::Internet.password
  end

  factory :book do
    sequence(:name) { |n| "Lorem Ipsum Dolor Sit Amet #{n}" }
  end
end
