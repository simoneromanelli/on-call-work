require 'rails_helper'

RSpec.describe ConversationsController, type: :controller do

  # describe "GET #index" do
  #   it "assigns all conversations as @conversations" do
  #     conversation = Conversation.create! valid_attributes
  #     get :index, {}, valid_session
  #     expect(assigns(:conversations)).to eq([conversation])
  #   end
  # end

  # describe "GET #show" do
  #   it "assigns the requested conversation as @conversation" do
  #     conversation = Conversation.create! valid_attributes
  #     get :show, {:id => conversation.to_param}, valid_session
  #     expect(assigns(:conversation)).to eq(conversation)
  #   end
  # end

  # describe "POST #create" do
  #   context "with valid params" do
  #     it "creates a new Conversation" do
  #       expect {
  #         post :create, {:conversation => valid_attributes}, valid_session
  #       }.to change(Conversation, :count).by(1)
  #     end

  #     it "assigns a newly created conversation as @conversation" do
  #       post :create, {:conversation => valid_attributes}, valid_session
  #       expect(assigns(:conversation)).to be_a(Conversation)
  #       expect(assigns(:conversation)).to be_persisted
  #     end

  #     it "redirects to the created conversation" do
  #       post :create, {:conversation => valid_attributes}, valid_session
  #       expect(response).to redirect_to(Conversation.last)
  #     end
  #   end

  #   context "with invalid params" do
  #     it "assigns a newly created but unsaved conversation as @conversation" do
  #       post :create, {:conversation => invalid_attributes}, valid_session
  #       expect(assigns(:conversation)).to be_a_new(Conversation)
  #     end

  #     it "re-renders the 'new' template" do
  #       post :create, {:conversation => invalid_attributes}, valid_session
  #       expect(response).to render_template("new")
  #     end
  #   end
  # end

  # describe "PUT #update" do
  #   context "with valid params" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }

  #     it "updates the requested conversation" do
  #       conversation = Conversation.create! valid_attributes
  #       put :update, {:id => conversation.to_param, :conversation => new_attributes}, valid_session
  #       conversation.reload
  #       skip("Add assertions for updated state")
  #     end

  #     it "assigns the requested conversation as @conversation" do
  #       conversation = Conversation.create! valid_attributes
  #       put :update, {:id => conversation.to_param, :conversation => valid_attributes}, valid_session
  #       expect(assigns(:conversation)).to eq(conversation)
  #     end

  #     it "redirects to the conversation" do
  #       conversation = Conversation.create! valid_attributes
  #       put :update, {:id => conversation.to_param, :conversation => valid_attributes}, valid_session
  #       expect(response).to redirect_to(conversation)
  #     end
  #   end

  #   context "with invalid params" do
  #     it "assigns the conversation as @conversation" do
  #       conversation = Conversation.create! valid_attributes
  #       put :update, {:id => conversation.to_param, :conversation => invalid_attributes}, valid_session
  #       expect(assigns(:conversation)).to eq(conversation)
  #     end

  #     it "re-renders the 'edit' template" do
  #       conversation = Conversation.create! valid_attributes
  #       put :update, {:id => conversation.to_param, :conversation => invalid_attributes}, valid_session
  #       expect(response).to render_template("edit")
  #     end
  #   end
  # end

  # describe "DELETE #destroy" do
  #   it "destroys the requested conversation" do
  #     conversation = Conversation.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => conversation.to_param}, valid_session
  #     }.to change(Conversation, :count).by(-1)
  #   end

  #   it "redirects to the conversations list" do
  #     conversation = Conversation.create! valid_attributes
  #     delete :destroy, {:id => conversation.to_param}, valid_session
  #     expect(response).to redirect_to(conversations_url)
  #   end
  # end

end
