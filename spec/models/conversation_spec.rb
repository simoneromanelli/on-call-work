require 'rails_helper'

RSpec.describe Conversation, type: :model do
  it 'has a valid factory' do
    expect(build(:conversation)).to be_valid
  end

  it 'contains errors if is invalid' do
    conversation = build(:conversation, :invalid_conversation)
    conversation.valid?
    expect(conversation.errors[:base])
      .to include 'Conversations can only happend between employer and employee'
  end

  it 'return the conversation partecipants calling .users' do
    conversation = create(:conversation)
    user_1 = conversation.sender_id
    user_2 = conversation.recipient_id
    users_ids = conversation.users.pluck(:id)
    expect(users_ids).to match_array([user_1, user_2])
  end
end
