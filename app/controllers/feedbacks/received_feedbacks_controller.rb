module Feedbacks
  class ReceivedFeedbacksController < FeedbacksController
    api! 'List of the feedback given by the current user'
    param :id, Integer, desc: 'User id', required: true

    def index
      super
      @feedbacks = User.find(params[:user_id]).feedbacks
      render json: @feedbacks, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { 'errors': ['Unknown user'] }
    end
  end
end
