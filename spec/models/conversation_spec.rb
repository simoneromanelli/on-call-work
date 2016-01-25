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

  it 'contains errors if users are the same' do
    puts 'ora'
    user = create(:user)
    conversation = build(
      :conversation,
      sender_id: user.id,
      recipient_id: user.id
    )
    conversation.valid?
    expect(conversation.errors[:base])
      .to include 'Sender and recipient can\'t be dthe same user'
  end

  it 'create new conversation if empty' do
    employee = create(:employee)
    employer = create(:employer)
    expect do
      Conversation.create_conversation_unless_exists(
        employee.id,
        employer.id
      )
    end.to change { Conversation.count }.by(1)
  end

  it 'does not create conversation if present' do
    employee = create(:employee)
    employer = create(:employer)
    Conversation.create(
      sender_id: employer.id,
      recipient_id: employee.id
    )
    expect do
      Conversation.create_conversation_unless_exists(
        employee.id,
        employer.id
      )
    end.to_not change { Conversation.count }
  end

  it 'create_conversation_unless_exists raise validation error if invalid' do
    employee_1 = create(:employee)
    employee_2 = create(:employee)
    conversation = Conversation.create_conversation_unless_exists(
      employee_1.id,
      employee_2.id
    )
    expect(conversation.errors.messages).to_not be_empty
  end

  it "create_conversation_unless_exists does not
    raise validation error if valid" do
    employee_1 = create(:employee)
    employee_2 = create(:employer)
    conversation = Conversation.create_conversation_unless_exists(
      employee_1.id,
      employee_2.id
    )
    expect(conversation.errors.messages).to be_empty
  end

  it 'return the conversation partecipants calling .users' do
    conversation = create(:conversation)
    user_1 = conversation.sender_id
    user_2 = conversation.recipient_id
    users_ids = conversation.users.pluck(:id)
    expect(users_ids).to match_array([user_1, user_2])
  end
end
