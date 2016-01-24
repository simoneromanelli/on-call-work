class ConversationsController < RestrictedController
  before_action :set_user, only: [:index]
  before_action :set_conversation, only: [:show, :update, :destroy]

  api! 'Return the not archived conversation for the given user'
  param :user_id, Integer, required: true
  def index
    authorize @user, :owner?
    @conversations = @user.conversations
    render json: @conversations
  rescue Pundit::NotAuthorizedError => e
    render status: 401, json: { errors: [e.message.split('?').first] }
  end

  private

  def set_user
    @user = User.find(params['user_id'])
  rescue ActiveRecord::RecordNotFound
    render json: { 'errors': ['Unknown user'] }
  end

  def set_conversation
    @conversation = Conversation.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { 'errors': ['Unknown work offer'] }
  end
end
