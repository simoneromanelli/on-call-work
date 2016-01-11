require 'faker'
FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    name { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    birth_year { Faker::Number.between(1950, 2016) }
    city { Faker::Address.city }
    employer { true }
    employee { false }

    factory :invalid_user do
      email { nil }
    end

    factory :employer do
      employer { true }
      employee { false }
    end

    factory :employee do
      employee { true }
      employer { false }
    end

    factory :unroled do
      employee { false }
      employer { false }
    end

    factory :user_withgiven_feedback do
      after(:build) do |user|
        3.times { user.given_feedbacks << build(:feedback) }
      end
    end
  end
end
