require 'rails_helper'

RSpec.describe JobApplicationsController, type: :controller do
  context 'when user is logged in' do
    before :each do
      @logged_user = create :employee
      AuthorizationHelper.authenticate_user(@logged_user, @request)
    end
    let(:valid_attributes) do
      build(:job_application, user_id: @logged_user.id).as_json
    end

    let(:invalid_attributes) do
      build(:invalid_job_application,
            work_offer_id: nil,
            user_id: @logged_user.id)
        .as_json
    end

    describe 'GET #index' do
      it 'assigns all job_applications as @job_applications' do
        job_application = JobApplication.create! valid_attributes
        get :index, format: 'json'
        expect(assigns(:job_applications)).to eq([job_application])
      end
    end

    describe 'GET #show' do
      it 'assigns the requested job_application as @job_application' do
        job_application = JobApplication.create! valid_attributes
        get :show, format: 'json', id: job_application.to_param
        expect(assigns(:job_application)).to eq(job_application)
      end

      it 'return errors if unknown job_applications' do
        get :show, format: 'json', id: 0
        json = JSON.parse(response.body)
          expect(json['errors']).to be_present
      end
    end

    describe 'POST #create' do
      context 'with valid params' do
        it 'creates a new JobApplication' do
          post :create, format: 'json', job_application: valid_attributes
          json = JSON.parse(response.body)
          expect(json['job_application']).to be_present
        end

        it 'assigns a newly created job_application as @job_application' do
          post :create, format: 'json', job_application: valid_attributes
          expect(assigns(:job_application)).to be_a(JobApplication)
        end
      end

      context 'with invalid params' do
        it 'return errors' do
          post :create, format: 'json', job_application: invalid_attributes
          json = JSON.parse(response.body)
          expect(json['errors']).to be_present
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'fails if trying to delete another employee job application' do
        valid_attributes['user_id'] = create(:employee).id
        job_application = JobApplication.create! valid_attributes
        delete :destroy, id: job_application.to_param
        json = JSON.parse(response.body)
        expect(json['errors']).to include 'not allowed to destroy'
      end

      it 'delete the given job_application' do
        job_application = JobApplication.create! valid_attributes
        expect { delete :destroy, format: 'json', id: job_application.to_param }
          .to change(JobApplication, :count).by(-1)
      end

      it 'return error if unknownjob application' do
        delete :destroy, format: 'json', id: 0
        json = JSON.parse(response.body)
        expect(json['errors']).to include 'Unknown job application'
      end
    end

  end
end