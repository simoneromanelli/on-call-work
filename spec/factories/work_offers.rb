FactoryGirl.define do
  factory :work_offer do
    title { Faker::Name.title }
    description { Faker::Lorem.sentence }
    company_name { Faker::Company.name }
    date_time { Faker::Time.between(DateTime.now + 1, DateTime.now + 30) }
    association :bidder, factory: :employer
    elected nil

    factory :invalid_work_offer do
      title nil
      description nil
    end

    factory :applyed_work_offer do
      association :elected, factory: :employee
    end

    factory :elected_is_an_emplyer_work_offer do
      association :elected, factory: :employer
    end

    factory :bidder_is_an_employee_work_offer do
      association :bidder, factory: :employee
    end

    factory :work_offer_with_feedbacks do
      after(:build) do |work_offer|
        work_offer.feedbacks << build(:feedback,
                                      writer_id: work_offer.bidder_id,
                                      subject_id: work_offer.elected_id
                                     )
        work_offer.feedbacks << build(:feedback,
                                      writer_id: work_offer.elected_id,
                                      subject_id: work_offer.bidder_id
                                     )
      end
    end

  end
end
