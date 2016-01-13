module Feedbacks
  class GivenFeedbacksController < FeedbacksController
    api! 'List of the feedback given by the current user'
    param :id, Integer, desc: 'User id', required: true

    def index
      super
      @given_feedbacks = User.find(params[:user_id]).given_feedbacks
      render json: @given_feedbacks, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { 'errors': ['Unknown feedback'] }
    end
  end
end
