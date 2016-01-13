require 'rails_helper'
require 'authorization_helper'

RSpec.describe Feedbacks::GivenFeedbacksController, type: :controller do
  before :each do
    @logged_user = create :user_with_given_feedbacks
    AuthorizationHelper.authenticate_user(@logged_user, @request)
  end

  context 'when user is logged in' do
    describe 'GET #index' do
      it 'assigns all the given feedbacks as given_feedbacks' do
        given_feedbacks = @logged_user.given_feedbacks
        get :index, format: 'json', user_id: @logged_user.id
        json = JSON.parse(response.body)
        expect(json['given_feedbacks'].size)
          .to eq given_feedbacks.size
      end

      it 'return error if user doesn\'t exist' do
        get :index, format: 'json', user_id: 0
        json = JSON.parse(response.body)
        expect(json['errors']).to include 'Unknown user'
      end
    end
  end
end
