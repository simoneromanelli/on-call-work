require 'rails_helper'

RSpec.describe WorkOffer, type: :model do
  it 'has valid factory' do
    expect(build :work_offer).to be_valid
  end

  it 'is invalid without title' do
    work_offer = build(:work_offer, title: nil)
    work_offer.valid?
    expect(work_offer.errors['title']).to include "can't be blank"
  end

  it 'is invalid without description' do
    work_offer = build(:work_offer, description: nil)
    work_offer.valid?
    expect(work_offer.errors['description']).to include "can't be blank"
  end

  it 'is invalid without date_time' do
    work_offer = build(:work_offer, date_time: nil)
    work_offer.valid?
    expect(work_offer.errors['date_time']).to include "can't be blank"
  end

  it 'is invalid with a past date' do
    work_offer = build(:work_offer, date_time: 2.days.ago)
    work_offer.valid?
    expect(work_offer.errors['date_time']).to include "can't be in the past"
  end

  it 'is invalid without company' do
    work_offer = build(:work_offer, company_name: nil)
    work_offer.valid?
    expect(work_offer.errors['company_name']).to include "can't be blank"
  end

  it 'is invalid without bidder' do
    work_offer = build(:work_offer, bidder_id: nil)
    work_offer.valid?
    expect(work_offer.errors['bidder_id']).to include "can't be blank"
  end

  it 'is invalid if bidder and elected are the same user' do
    user = build(:user)
    work_offer = build(:work_offer, bidder_id: user.id, elected_id: user.id)
    work_offer.valid?
    expect(work_offer.errors['base'])
      .to include "bidder and elected can't the same user"
  end

  it 'only employers can be work offer bidder' do
    work_offer = build(:bidder_is_an_employee_work_offer)
    work_offer.valid?
    expect(work_offer.errors['base'])
      .to include 'only employers can be work offer bidder'
  end

  it 'only employees can be elected for a work_offer' do
    work_offer = build(:elected_is_an_emplyer_work_offer)
    work_offer.valid?
    expect(work_offer.errors['base'])
      .to include 'only employees can be elected for a work offer'
  end
end
