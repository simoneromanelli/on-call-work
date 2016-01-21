require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) { attributes_for(:user) }
  let(:invalid_attributes) { attributes_for(:invalid_user) }

  context 'when user is logged in' do
    before :each do
      @logged_user = create :user
      AuthorizationHelper.authenticate_user(@logged_user, @request)
    end

    describe 'GET #index' do
      it 'return a users JSON' do
        get :index, {}
        json = JSON.parse(response.body)
        expect(json['users'].first['email']).to eq @logged_user.email
      end
    end

    describe 'GET #show' do
      it 'return the user' do
        user_params = { format: 'json', id: @logged_user.id }
        get :show, user_params
        json = JSON.parse(response.body)
        expect(json['email']).to eq @logged_user.email
      end
    end

    describe 'PUT #update' do
      it 'return 401 unauthorized if try to update another user' do
        user = create :user
        user_params = { format: 'json', id: user.id, user: valid_attributes }

        put :update, user_params
        json = JSON.parse(response.body)
        expect(json['errors']).to include 'not allowed to update'
      end

      it 'return error if params are not valid' do
        user_params = { format: 'json',
                        id: @logged_user.id,
                        user: invalid_attributes
                      }

        put :update, user_params
        json = JSON.parse(response.body)
        expect(json['errors']).to include "Email can't be blank"
      end

      it 'update user if params are valid' do
        user_params = { format: 'json',
                        id: @logged_user.id, user: valid_attributes
                      }

        put :update, user_params
        json = JSON.parse(response.body)
        expect(json[:name]).to eq valid_attributes['name']
      end
    end

    describe 'DELETE #destroy' do
      it 'delete an user if legged user has permissions'
      it 'deny to delete another user'
    end
  end

  context 'when user is not logged in' do
    describe 'GET #index' do
      it 'return a 401 status' do
        get :index, {}
        expect(response.status).to eq 401
      end
    end

    describe 'GET #show' do
      it 'return a 401 status' do
        user = create :user
        get :show, format: 'json', id: user.id
        expect(response.status).to eq 401
      end
    end

    describe 'PUT #update' do
      it 'return a 401 status' do
        user = create :user
        put :update, format: 'json', id: user.id
        expect(response.status).to eq 401
      end
    end

    describe 'DELETE #destroy' do
      it 'return a 401 status'
    end

    describe 'POST #create' do
      it 'create a new user if user is valid' do
        user_params = { format: 'json', user: valid_attributes }
        post :create, user_params
        json = JSON.parse(response.body)
        expect(json.keys).not_to include 'errors'
      end

      it 'send a confirmation email after create' do
        user_params = { format: 'json', user: valid_attributes }
        post :create, user_params
        expect(ActionMailer::Base.deliveries.last.to)
          .to include valid_attributes[:email]
      end

      it 'return error if user params are not invalid' do
        user_params = { format: 'json', user: invalid_attributes }
        post :create, user_params
        json = JSON.parse(response.body)
        expect(json.keys).to include 'errors'
      end
    end
  end
end
