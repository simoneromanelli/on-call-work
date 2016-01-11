require 'rails_helper'
require 'authorization_helper'

RSpec.describe FeedbacksController, type: :controller do
  let(:valid_attributes) { attributes_for(:feedback) }
  let(:invalid_attributes) { attributes_for(:invalid_feedback) }

  context 'when user is logged in' do
    before :each do 
      @logged_user = create :user
      AuthorizationHelper.authenticate_user(@logged_user, @request)
    end

    # describe 'GET #index' do
    #   it 'assigns all feedbacks as @feedbacks' do
    #     feedback = create :feedback
    #     get :index, { format: 'json'}
    #     json = JSON.parse(response.body)
    #     expect(json.first['created_at']).to eq (feedback.created_at)
    #     # expect(json).to eq([feedback.as_json])
    #   end
    # end

    # describe 'GET #show' do
    #   it 'assigns the requested feedback as @feedback' do
    #     feedback = create :feedback
    #     get :show, {id: feedback.id}
    #     expect(assigns(:feedback)).to eq(feedback)
    #   end
    # end

    # describe 'GET #new' do
    #   it 'assigns a new feedback as @feedback' do
    #     get :new, {}
    #     expect(assigns(:feedback)).to be_a_new(Feedback)
    #   end
    # end

    # describe 'GET #edit' do
    #   it 'assigns the requested feedback as @feedback' do
    #     feedback = create :feedback
    #     get :edit, {id: feedback.to_param}
    #     expect(assigns(:feedback)).to eq(feedback)
    #   end
    # end

    # describe 'POST #create' do
    #   context 'with valid params' do
    #     it 'creates a new Feedback' do
    #       expect {
    #         post :create, {:feedback => valid_attributes}
    #       }.to change(Feedback, :count).by(1)
    #     end

    #     it 'assigns a newly created feedback as @feedback' do
    #       post :create, {:feedback => valid_attributes}
    #       expect(assigns(:feedback)).to be_a(Feedback)
    #       expect(assigns(:feedback)).to be_persisted
    #     end

    #     it 'redirects to the created feedback' do
    #       post :create, {:feedback => valid_attributes}
    #       expect(response).to redirect_to(Feedback.last)
    #     end
    #   end

    #   context 'with invalid params' do
    #     it 'assigns a newly created but unsaved feedback as @feedback' do
    #       post :create, {:feedback => invalid_attributes}
    #       expect(assigns(:feedback)).to be_a_new(Feedback)
    #     end

    #     it 're-renders the \'new\' template' do
    #       post :create, {:feedback => invalid_attributes}
    #       expect(response).to render_template('new')
    #     end
    #   end
    # end

    # describe 'PUT #update' do
    #   context 'with valid params' do
    #     let(:new_attributes) {
    #       skip('Add a hash of attributes valid for your model')
    #     }

    #     it 'updates the requested feedback' do
    #       feedback = create :feedback
    #       put :update, {id: feedback.to_param, :feedback => new_attributes}
    #       feedback.reload
    #       skip('Add assertions for updated state')
    #     end

    #     it 'assigns the requested feedback as @feedback' do
    #       feedback = create :feedback
    #       put :update, {id: feedback.to_param, :feedback => valid_attributes}
    #       expect(assigns(:feedback)).to eq(feedback)
    #     end

    #     it 'redirects to the feedback' do
    #       feedback = create :feedback
    #       put :update, {id: feedback.to_param, :feedback => valid_attributes}
    #       expect(response).to redirect_to(feedback)
    #     end
    #   end

    #   context 'with invalid params' do
    #     it 'assigns the feedback as @feedback' do
    #       feedback = create :feedback
    #       put :update, {id: feedback.to_param, :feedback => invalid_attributes}
    #       expect(assigns(:feedback)).to eq(feedback)
    #     end

    #     it 're-renders the \'edit\' template' do
    #       feedback = create :feedback
    #       put :update, {id: feedback.to_param, :feedback => invalid_attributes}
    #       expect(response).to render_template('edit')
    #     end
    #   end
    # end

    # describe 'DELETE #destroy' do
    #   it 'destroys the requested feedback' do
    #     feedback = create :feedback
    #     expect {
    #       delete :destroy, {id: feedback.to_param}
    #     }.to change(Feedback, :count).by(-1)
    #   end

    #   it 'redirects to the feedbacks list' do
    #     feedback = create :feedback
    #     delete :destroy, {id: feedback.to_param}
    #     expect(response).to redirect_to(feedbacks_url)
    #   end
    # end
  end
end