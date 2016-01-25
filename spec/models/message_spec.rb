require 'rails_helper'

RSpec.describe Message, type: :model do
  it 'has a valid factory' do
    expect(build :message).to be_valid
  end

  it 'is invalid without text' do
    message = build(:message, text: nil)
    message.valid?
    expect(message.errors[:text]).to include "can't be blank"
  end

  it 'is invalid without conversation' do
    message = build(:message, conversation_id: nil)
    message.valid?
    expect(message.errors[:conversation_id]).to include "can't be blank"
  end

  it 'is invalid without user' do
    message = build(:message, user_id: nil)
    message.valid?
    expect(message.errors[:user_id]).to include "can't be blank"
  end
end
