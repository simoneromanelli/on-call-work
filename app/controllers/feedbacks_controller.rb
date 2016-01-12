class FeedbacksController < RestrictedController

  def_param_group :given_feedback do
    param :given_feedback, Hash, required: true do
      param :user_id, Integer,
            desc: 'id of the user that create the feedback.', required: true
      param :rating, [1, 2, 3, 4, 5], 'Rate for the user.', required: true
      param :text, String, 'Performance description.', required: true
      param :subject_id, Integer, 'Id of the rated user.', required: true
      param :work_offer_id, Integer, 'Id of the work offer.', required: true
    end
  end
  # before_action only: [:index, :create] { authorize_class Feedback}
  # before_action :set_feedback, only: [:show, :update, :destroy]
  # before_action only: [:show, :update, :destroy] { authorize_instace @feedback}

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

  api! 'Create feedback'
  param_group :given_feedback

  def create
    @feedback = Feedback.new feedback_params
    authorize @feedback
    if @feedback.save
      render json: @feedback, status: :created, location: @feedback
    else
      render json: { errors: @feedback.errors.full_messages },
             status: :unprocessable_entity
    end
  rescue Pundit::NotAuthorizedError => e
    render status: 401, json: { errors: [e.message.split('?').first] }
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

    private

    def feedback_params
      params.require(:feedback).permit(
        [
          :text,
          :rating,
          :work_offer_id,
          :subject_id,
          :writer_id
        ]
      )
    end
end
