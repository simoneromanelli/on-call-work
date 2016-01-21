require 'rails_helper'

RSpec.describe WorkOffersController, type: :controller do

  context 'when user is logged in' do
    before :each do
      @logged_user = create :employer
      AuthorizationHelper.authenticate_user(@logged_user, @request)
    end

    describe 'GET #index' do
      it 'return the work_offers list' do
        work_offer = create(:work_offer)
        get :index, format: 'json'
        expect(assigns(:work_offers)).to match_array([work_offer])
      end
    end

    describe 'GET #show' do
      it 'return the work_offers list' do
        work_offer = create(:work_offer)
        get :show, format: 'json', id: work_offer.id
        json = JSON.parse(response.body)
        expect(json['work_offer']).to be_present
      end

      it 'return error if unknown work offer' do
        get :show, format: 'json', id: 0
        json = JSON.parse(response.body)
        expect(json['errors']).to include 'Unknown work offer'
      end
    end
  end

  context 'when user is logged in and he is an employer' do
    before :each do
      @logged_user = create :employer
      AuthorizationHelper.authenticate_user(@logged_user, @request)
    end
    let(:valid_attributes) do
      attributes_for(:work_offer)
        .merge(bidder_id: @logged_user.id)
    end
    let(:invalid_attributes) do
      attributes_for(:invalid_work_offer)
        .merge(bidder_id: @logged_user.id)
    end

    describe 'POST #create' do
      context 'with valid params' do
        it 'create a new work offer' do
          post :create,
               format: 'json',
               work_offer: valid_attributes
          json = JSON.parse(response.body)
          expect(json['work_offer']).to be_present
        end
      end
      context 'with invalid params' do
        it 'return error' do
          post :create,
               format: 'json',
               work_offer: invalid_attributes
          json = JSON.parse(response.body)
          expect(json['errors']).to be_present
        end
      end
    end

    describe 'PUT #update' do
      context 'with valid params' do
        it 'updates the requested work_offer' do
          work_offer = create(:work_offer, bidder_id: @logged_user.id)
          new_attributes = { title: Faker::Name.title }
          put :update,
              fotmat: 'json',
              id: work_offer.id,
              work_offer: new_attributes
          json = JSON.parse(response.body)
          expect(json['work_offer']['title']).to eq new_attributes[:title]
        end

        it 'return error with invalid attributes' do
          work_offer = create(:work_offer, bidder_id: @logged_user.id)
          new_attributes = { title: nil }
          put :update,
              fotmat: 'json',
              id: work_offer.id,
              work_offer: new_attributes
          json = JSON.parse(response.body)
          expect(json['errors']).to be_present
        end

        it 'return error if unknown work offer' do
          put :update, format: 'json', id: 0
          json = JSON.parse(response.body)
          expect(json['errors']).to include 'Unknown work offer'
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'fails if trying to delete another employer work offer' do
        user = create :employer
        work_offer = create(:work_offer, bidder_id: user.id)
        delete :destroy, id: work_offer.to_param
        json = JSON.parse(response.body)
        expect(json['errors']).to include 'not allowed to destroy'
      end

      it 'delete the given work_offer' do
        work_offer = create(:work_offer, bidder_id: @logged_user.id)
        expect { delete :destroy, format: 'json', id: work_offer.to_param }
          .to change(WorkOffer, :count).by(-1)
      end

      it 'return error if unknown work offer' do
        delete :destroy, format: 'json', id: 0
        json = JSON.parse(response.body)
        expect(json['errors']).to include 'Unknown work offer'
      end
    end
  end

  context 'when user is logged in and he is an employee' do
    before :each do
      @logged_user = create :employee
      AuthorizationHelper.authenticate_user(@logged_user, @request)
    end

    let(:valid_attributes) do
      attributes_for(:work_offer)
        .merge(bidder_id: @logged_user.id)
    end

    describe 'POST #create' do
      context 'with valid params' do
        it 'create a new work offer' do
          post :create,
               format: 'json',
               work_offer: valid_attributes
          json = JSON.parse(response.body)
          expect(json['errors']).to include 'not allowed to create'
        end
      end
    end
  end
end
