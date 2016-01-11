class FeedbacksController < ApplicationController
  before_action only: [:index, :create] { authorize_class Feedback}
  before_action :set_userfeedback, only: [:show, :update, :destroy]
  before_action only: [:show, :update, :destroy] { authorize_instace @feedback}

  # GET /feedbacks
  # GET /feedbacks.json
  def index
    @feedbacks = Feedback.all
    
    render json: @feedbacks
  end

  # GET /feedbacks/1
  # GET /feedbacks/1.json
  def show
    render json: @feedback
  end

  # POST /feedbacks
  # POST /feedbacks.json
  def create
    @feedback = Feedback.new(feedback_params)

    if @feedback.save
      render json: @feedback, status: :created, location: @feedback
    else
      render json: @feedback.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /feedbacks/1
  # PATCH/PUT /feedbacks/1.json
  def update
    @feedback = Feedback.find(params[:id])

    if @feedback.update(feedback_params)
      head :no_content
    else
      render json: @feedback.errors, status: :unprocessable_entity
    end
  end

  # DELETE /feedbacks/1
  # DELETE /feedbacks/1.json
  def destroy
    @feedback.destroy

    head :no_content
  end

  private

    def set_feedback
      @feedback = Feedback.find(params[:id])
    end

    def feedback_params
      params.require(:feedback).permit(:subject_id_id, :writer_id_id, :text, :rating, :work_offer_id)
    end
end
