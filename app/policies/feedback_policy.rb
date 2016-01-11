class FeedbackPolicy < ApplicationPolicy

  def index?
    true
  end

  def create?
    true
  end

  def update?
    @user.id == @record.writer_id
  end
end
