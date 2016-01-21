require 'rails_helper'

RSpec.describe JobApplication, type: :model do
  it 'has_valid_factory' do
    expect(build :job_application).to be_valid
  end

  it 'is invalid if employer try to apply' do
    job_application = build(:invalid_job_application)
    job_application.valid?
    expect(job_application.errors['base'])
      .to include 'Employee only can apply to a work offer'
  end
end
