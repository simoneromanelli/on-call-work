require 'rails_helper'
require 'user_helper'
RSpec.describe UsersController, type: :controller do

  let(:valid_user) { attributes_for(:user) }
  let(:invalid_user) { attributes_for(:invalid_user) }

  context 'When user is logged in' do
    describe 'GET #index' do
      it 'return a users JSON' do
        user = create :user
        UserHelper.authenticate_user(user, @request)
        get :index, {}
        json = JSON.parse(response.body)
        expect(json.first['email']).to eq user.email
      end
    end
  end

  context 'When user is logged in' do
    describe 'GET #index' do
      it 'return a 401 status' do
        get :index, {}
        expect(response.status).to eq 401
      end
    end

    describe 'POST #create' do
      it 'create a new user if user is valid' do
        user_params = { format: 'json', user: valid_user }
        post :create, user_params
        json = JSON.parse(response.body)
        expect(json.keys).not_to include 'errors'
      end

      it 'return error if user is invalid' do
        user_params = { format: 'json', user: invalid_user }
        post :create, user_params
        json = JSON.parse(response.body)
        expect(json.keys).to include 'errors'
      end
    end
  end
end
