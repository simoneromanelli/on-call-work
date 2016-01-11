require 'rails_helper'
require 'authorization_helper'

module Feedbacks
  RSpec.describe GivenFeedbacksController, type: :controller do
    context 'when user is logged in' do
      before :each do 
        @logged_user = create :user_withgiven_feedback
        AuthorizationHelper.authenticate_user(@logged_user, @request)
      end

      describe 'GET #index' do
        it 'assigns all feedbacks as @feedbacks' do
          given_feedbacks = @logged_user.given_feedbacks
          get :index, format: 'json', user_id: @logged_user
          json = JSON.parse(response.body)
          expect(json).to eq given_feedbacks
        end
      end
    end
  end
end