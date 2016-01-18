require 'rails_helper'
require 'authorization_helper'

RSpec.describe FeedbacksController, type: :controller do

  context 'when user is logged in' do
    before :each do
      @logged_user = create :user
      AuthorizationHelper.authenticate_user(@logged_user, @request)
    end
    let(:valid_attributes) do
      attributes_for(:feedback)
        .merge(subject_id: create(:user).id)
        .merge(writer_id: @logged_user.id)
    end
    let(:invalid_attributes) do
      attributes_for(:invalid_feedback)
        .merge(subject_id: create(:user).id)
        .merge(writer_id: @logged_user.id)
    end

    describe 'POST #create' do
      it 'create feedback if params are valid' do
        post :create,
             format: 'json',
             feedback: valid_attributes
        json = JSON.parse(response.body)
        expect(json['feedback']).to be_present
      end

      it 'fails if invalid params' do
        post :create,
             format: 'json',
             feedback: invalid_attributes
        json = JSON.parse(response.body)
        expect(json['errors']).to include 'Text can\'t be blank'
      end

      it 'return policy error if user_id != current_user' do
        user = create :user
        valid_attributes['writer_id'] = user.id
        post :create,
             format: 'json',
             feedback: valid_attributes
        json = JSON.parse(response.body)
        expect(json['errors']).to include 'not allowed to create'
      end
    end

    describe 'GET #show' do
      it 'assigns the requested feedback as @feedback' do
        feedback = create :feedback
        get :show, id: feedback.id
        expect(assigns(:feedback)).to eq(feedback)
      end

      it 'raise exception if feedback doesn\'t exist' do
        get :show, id: 0
        json = JSON.parse(response.body)
        expect(json['errors']).to include 'Unknown feedback'
      end
    end

    describe 'PUT #update' do
      context 'with valid params' do
        it 'updates the requested feedback' do
          feedback = create(:feedback, writer_id: @logged_user.id)
          put :update,
              id: feedback.id,
              feedback: {
                           text: Faker::Lorem.sentence,
                           writer_id: @logged_user.id
                        }
          json = JSON.parse(response.body)
          expect(json['feedback']).to be_present
        end

        it 'deny update if feedback is created more than one day ago' do
          feedback = create(:feedback, created_at: Time.now - 2.days)
          put :update,
              id: feedback.id,
              feedback: { text: Faker::Lorem.sentence }
          json = JSON.parse(response.body)
          expect(json['errors']).to include 'not allowed to update'
        end

        it 'deny update if try to update another user\'s feedback' do
          feedback = create(:feedback)
          put :update,
              id: feedback.id,
              feedback: { text: Faker::Lorem.sentence }
          json = JSON.parse(response.body)
          expect(json['errors']).to include 'not allowed to update'
        end
      end
    end
  end
end
