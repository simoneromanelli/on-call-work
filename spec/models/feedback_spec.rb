require 'rails_helper'

RSpec.describe Feedback, type: :model do
  it 'has valid factory' do
    expect(build :feedback).to be_valid
  end

  it 'is invalid without rating' do
    feedback = build(:feedback, rating: nil)
    feedback.valid?
    expect(feedback.errors['rating']).to include "can't be blank"
  end

  it 'is invalid without text' do
    feedback = build(:feedback, text: nil)
    feedback.valid?
    expect(feedback.errors['text']).to include "can't be blank"
  end

  it 'is invalid if writer is the subject and vice versa' do
    user = build :user
    feedback = build(:feedback, writer: user, subject: user)
    feedback.valid?
    expect(feedback.errors['base'])
      .to include 'Writer and subject must be different users'
  end

  it 'is invalid without a work_offer' do
    feedback = build(:feedback, work_offer: nil)
    feedback.valid?
    expect(feedback.errors['work_offer']).to include "can't be blank"
  end
end
