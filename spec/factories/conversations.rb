FactoryGirl.define do
  factory :conversation do
    association :sender, factory: :employer
    association :recipient, factory: :employee
    archived false

    trait :invalid_conversation do
      association :recipient, factory: :employer
    end

    trait :with_messages do
      after(:create) do |conversation|
        messages = [
          create(:message, user_id: conversation.sender.id),
          create(:message, user_id: conversation.recipient.id)
        ]
        conversation.messages << messages
      end
    end
  end
end
