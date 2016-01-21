require 'faker'
FactoryGirl.define do
  factory :feedback do
    association :writer, factory: :user
    association :subject, factory: :user
    association :work_offer, factory: :work_offer
    text { Faker::Lorem.sentence }
    rating { Faker::Number.between(1, 5) }

    factory :invalid_feedback do
      text { nil }
    end
  end
end
