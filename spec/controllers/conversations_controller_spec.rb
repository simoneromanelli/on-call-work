require 'rails_helper'

RSpec.describe ConversationsController, type: :controller do
  before :each do
    @logged_user = create :employer
    AuthorizationHelper.authenticate_user(@logged_user, @request)
  end

  describe 'GET #index' do
    it 'return the conversations for the given user' do
      conversation = create(
        :conversation,
        :with_messages,
        sender_id: @logged_user.id
      )
      get :index, format: 'json', user_id: @logged_user.id
      expect(assigns(:conversations)).to eq([conversation])
    end

    it 'return authorization error if try to get another user conversations' do
      conversation = create(
        :conversation,
        :with_messages
      )
      get :index, format: 'json', user_id: conversation.sender_id
      json = JSON.parse(response.body)
      expect(json['errors']).to include 'not allowed to owner'
    end
  end
end
