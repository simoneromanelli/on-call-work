class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def update?
    byebug
  end
end
