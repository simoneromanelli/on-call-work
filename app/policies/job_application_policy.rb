class JobApplicationPolicy < ApplicationPolicy

  def index?
    true
  end

  def create?
    @user.employee?
  end

  def destroy?
    @user.employee? && @user.id == @record.user_id
  end
end
