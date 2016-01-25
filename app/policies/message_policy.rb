class MessagePolicy < ApplicationPolicy
  def create?
    @record.user_id == @user.id
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end