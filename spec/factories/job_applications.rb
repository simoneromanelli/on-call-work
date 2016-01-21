FactoryGirl.define do
  factory :job_application do
    association :user, factory: :employee
    association :work_offer, factory: :work_offer

    factory :invalid_job_application do
      association :user, factory: :employer
    end
  end
end
