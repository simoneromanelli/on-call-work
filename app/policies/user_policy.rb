class UserPolicy < ApplicationPolicy

  def index?
    true
  end

  def create?
    true
  end

  def update?
    @user.id == @record.id
  end
end
