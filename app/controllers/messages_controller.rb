#
class MessagesController < RestrictedController
  before_action :set_message, only: [:update, :destroy]


  api! 'Insert a new message in users\'s conversation'
  param :message, Hash do
    param :user_id, Integer, 'Id of the writer user', required: true
    param :text, String, 'Body of the message', required: true
  end
  param :recipient_id, Integer, 'Id of the recipient user'
  def create
    conversation = Conversation.create_conversation_unless_exists(
      message_params[:user_id],
      params[:recipient_id]
    )
    authorize conversation
    unless conversation.errors.messages.empty?
      render json: {
        'errors': [
          'Some errors occour updating the conversation'
        ] + conversation.errors.full_messages
      }, status: :unprocessable_entity
      return false
    end
    @message = Message.new(
      message_params.merge(conversation_id: conversation.id)
    )
    authorize @message
    if @message.save
      conversation.messages << @message
      render status: :created, json: conversation
    else
      render json: { errors: @message.errors }, status: :unprocessable_entity
    end
  rescue Pundit::NotAuthorizedError => e
    render status: 401, json: { errors: [e.message.split('?').first] }
  end

  api! 'Update the message'
  param :message_id, Integer, 'Id of the given message'
  def update
    authorize @message

    if @message.update(updatable_message_params)
      render json: @message.conversation, status: :ok
    else
      render json: { errors: @message.errors }, status: :unprocessable_entity
    end
  rescue Pundit::NotAuthorizedError => e
    render status: 401, json: { errors: [e.message.split('?').first] }
  end

  api! 'Delete the message'
  param :message_id, Integer, 'Id of the given message'
  def destroy
    authorize @message
    @message.destroy
    render status: :ok, nothing: true
  rescue Pundit::NotAuthorizedError => e
    render status: 401, json: { errors: [e.message.split('?').first] }
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :text)
  end

  def updatable_message_params
    params.require(:message).permit(:text)
  end

  def set_message
    @message = Message.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { 'errors': ['Unknown message'] },
           status: :unprocessable_entity
  end
end
