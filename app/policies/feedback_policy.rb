class FeedbackPolicy < ApplicationPolicy

  def index?
    true
  end

  def create?
    @user.id == @record.writer_id
  end

  def update?
    create?
  end
end
