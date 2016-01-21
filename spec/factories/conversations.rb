FactoryGirl.define do
  factory :conversation do
    association :sender, factory: :employer
    association :recipient, factory: :employee

    trait :invalid_conversation do
      association :recipient, factory: :employer
    end
  end
end
