require 'faker'
FactoryGirl.define do
  factory :feedback do
    association :writer, factory: :user
    association :subject, factory: :user
    text { Faker::Lorem.sentence }
    rating { Faker::Number.between(1, 5) }
    # work_offer nil
  end

  factory :invalid_feedback do
    text { nil }
  end
end 
