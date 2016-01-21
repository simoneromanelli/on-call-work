#
class JobApplicationsController < ApplicationController
  def_param_group :job_application do
    param :job_application, Hash, required: true do
      param :user_id, Integer,
            'Id of the employee that want to apply a work offer', required: true
      param :work_offer_id, Integer,
            'Id of work offer', required: true
    end
  end

  before_action :set_job_application, only: [:show, :update, :destroy]

  api! 'List of job application'
  def index
    authorize JobApplication
    @job_applications = JobApplication.all

    render json: @job_applications
  end

  api! 'Return the job_application'
  param :id, Integer, 'id of the job_application'
  def show
    authorize @job_application
    render json: @job_application
  end

  api! 'Create a job_application'
  param_group :job_application
  def create
    @job_application = JobApplication.new(job_application_params)
    authorize @job_application

    if @job_application.save
      render json: @job_application,
             status: :created,
             location: @job_application
    else
      render json: { errors: @job_application.errors.full_messages },
             status: :unprocessable_entity
    end
  rescue Pundit::NotAuthorizedError => e
    render status: 401, json: { errors: [e.message.split('?').first] }
  end

  api! 'Delete the job_application'
  param :id, Integer, 'id of the job_application'
  def destroy
    authorize @job_application
    @job_application.destroy
    render status: :ok, nothing: true
  rescue Pundit::NotAuthorizedError => e
    render status: 401, json: { errors: [e.message.split('?').first] }
  end

  private

  def set_job_application
    @job_application = JobApplication.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { 'errors': ['Unknown job application'] }
  end

  def job_application_params
    params.require(:job_application).permit(:user_id, :work_offer_id)
  end
end
