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
  end

  factory :employer do 
    employer { true }
    employee { false }
  end

  factory :employee do 
    employee { true }
    employer { false }
  end
end
