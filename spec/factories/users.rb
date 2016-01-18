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

    factory :employer_with_works_offers_applied_and_reviewed_from_both do
      employer { true }
      employee { false }
      after(:create) do |employer|
        puts employer.id
        2.times do
          employee = create(:employee)
          employer.work_offers << create(
            :work_offer,
            bidder_id: employer.id,
            elected_id: employee.id
          )
          employer.work_offers.each do |work_offer|
            work_offer.feedbacks << create(
              :feedback,
              subject_id: employee.id,
              writer_id: employer.id,
              work_offer_id: work_offer.id
            )
            work_offer.feedbacks << create(
              :feedback,
              subject_id: employer.id,
              writer_id: employee.id,
              work_offer_id: work_offer.id
            )
          end
        end
      end
    end

    factory :employee do
      employee { true }
      employer { false }
    end

    factory :unroled do
      employee { false }
      employer { false }
    end

    factory :user_with_given_feedbacks do
      after(:build) do |user|
        3.times { user.given_feedbacks << build(:feedback) }
      end
    end

    factory :user_with_feedbacks do
      after(:build) do |user|
        3.times { user.feedbacks << build(:feedback) }
      end
    end
  end
end
