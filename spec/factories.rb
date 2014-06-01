FactoryGirl.define do  
  factory :user do
    name { Faker::Name.name }
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password Faker::Internet.password
  end

  factory :book do
    sequence(:name) { |n| "Lorem Ipsum Dolor Sit Amet #{n}" }

    image do
      r = rand(1..4)
      File.new(Rails.root.join("spec/support/images/0#{r}.png"))
    end

    sequence(:amazon_asin) { |n| "EXAMPLEASIN#{n}" }
  end

  factory :tag do
    sequence(:name) { |n| "Tag #{n}" }
  end

  factory :node

end
