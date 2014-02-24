FactoryGirl.define do  
  factory :book do
    sequence(:name) { |n| "Lorem Ipsum Dolor Sit Amet #{n}" }
  end
end
