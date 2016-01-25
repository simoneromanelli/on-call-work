class ConversationPolicy < ApplicationPolicy
  def create?
    @record.sender_id == @user.id ||
      @record.recipient_id == @user.id
  end
end