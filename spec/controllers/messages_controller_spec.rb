require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  before :each do
    @logged_user = create :employer
    AuthorizationHelper.authenticate_user(@logged_user, @request)
  end

  let(:valid_attributes) { attributes_for(:message) }

  let(:invalid_attributes) { attributes_for(:invalid_message) }

  describe 'POST #create' do
    it 'return status created when created' do
      employee = create(:employee)
      post :create,
           format: 'json',
           message: attributes_for(:message).merge(user_id: @logged_user.id),
           recipient_id: employee.id
      expect(response).to have_http_status(:created)
    end

    it 'create new message and return the given conversation id' do
      employee = create(:employee)
      post :create,
           format: 'json',
           message: attributes_for(:message).merge(user_id: @logged_user.id),
           recipient_id: employee.id
      json = JSON.parse(response.body)
      expect(json['conversation']).to be_present
    end

    it 'fails on invalid conversation' do
      employee = create(:employer)
      post :create,
           format: 'json',
           message: attributes_for(:message).merge(user_id: @logged_user.id),
           recipient_id: employee.id
      json = JSON.parse(response.body)
      expect(json['errors'])
        .to include 'Some errors occour updating the conversation'
    end

    it 'fails on invalid message' do
      employee = create(:employee)
      post :create,
           format: 'json',
           message: invalid_attributes.merge(user_id: @logged_user.id),
           recipient_id: employee.id
      json = JSON.parse(response.body)
      expect(json['errors']['text']).to include 'can\'t be blank'
    end

    it "raise authorization error if user
      try to send message for another one" do
      employee = create(:employee)
      employer = create(:employer)
      post :create,
           format: 'json',
           message: invalid_attributes.merge(user_id: employer.id),
           recipient_id: employee.id
      json = JSON.parse(response.body)
      expect(json['errors']).to include 'not allowed to create'
    end
  end

  describe 'put #update' do
    it 'update the given message' do
      message = create(:message, user_id: @logged_user.id)
      new_attributes = attributes_for(:message)
      put :update,
          format: 'json',
          id: message.id,
          message: new_attributes
      json = JSON.parse(response.body)

      expect(json['conversation']['messages'].first['text'])
        .to eq new_attributes[:text]
    end

    it 'fails if try to update another user\'s message' do
      user = create(:user)
      message = create(:message, user_id: user.id)
      new_attributes = attributes_for(:message)
      put :update,
          format: 'json',
          id: message.id,
          message: new_attributes
      json = JSON.parse(response.body)

      expect(json['errors']).to include 'not allowed to update'
    end

    it 'return unprocessable_entity if message doesn\'t exist' do
      new_attributes = attributes_for(:message)
      put :update,
          format: 'json',
          id: 0,
          message: new_attributes
      json = JSON.parse(response.body)
      expect(json['errors'])
        .to include 'Unknown message'
    end
  end

  describe 'put #update' do
    it 'delete the given message' do
      message = create(:message, user_id: @logged_user.id)
      expect do
        delete :destroy,
               format: 'json',
               id: message.id
      end.to change { Message.count }.by(-1)
    end

    it 'fails if try to delete another user\'s message' do
      message = create(:message)
      delete :destroy,
             format: 'json',
             id: message.id
      json = JSON.parse(response.body)
      expect(json['errors']).to include 'not allowed to destroy'
    end
  end
end
