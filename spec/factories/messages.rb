FactoryGirl.define do
  factory :message do
    text { Faker::Lorem.sentence }
    association :conversation, factory: :conversation
    association :user, factory: :user
    read false
  end
end
