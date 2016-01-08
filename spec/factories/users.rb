require 'faker'
FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    name { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    birth_year { Faker::Number.number(4) }
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
  end
end
