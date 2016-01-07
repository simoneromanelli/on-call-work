require 'rails_helper'
require 'user_helper'
RSpec.describe UsersController, type: :controller do

  describe "GET #index" do
    it "assigns all users as @users" do
      user = create :user
      UserHelper.authenticate_user(user, @request)
      get :index, {}
      json = JSON.parse(response.body)
      expect(json.first['email']).to eq user.email
    end
  end 
end
