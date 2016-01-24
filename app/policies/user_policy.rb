class UserPolicy < ApplicationPolicy

  def owner?
    @user.id == @record.id
  end

  def index?
    true
  end

  def create?
    true
  end

  def update?
    owner?
  end
end
