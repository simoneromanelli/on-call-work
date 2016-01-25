FactoryGirl.define do
  factory :message do
    text { Faker::Lorem.sentence }
    association :conversation, factory: :conversation
    association :user, factory: :user
    read false

    factory :invalid_message do
      text nil
    end

    trait :from_employer do
      association :user, factory: :employer
    end
  end
end
