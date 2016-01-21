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
end
