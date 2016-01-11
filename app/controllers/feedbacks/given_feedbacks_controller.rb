module Feedbacks
  class GivenFeedbacksController < FeedbacksController
    def index
      @given_feedbacks = User.find(params[:user_id]).given_feedbacks
      render json: @given_feedbacks.as_json, status: :ok
    end
  end
end