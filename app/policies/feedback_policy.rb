class FeedbackPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def create?
    @user.id == @record.writer_id
  end

  def update?
    create? && Time.now - @record.created_at < 1.days
  end
end
