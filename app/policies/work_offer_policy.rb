class WorkOfferPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def create?
    @user.id == @record.bidder_id &&
      @user.employer?
  end

  def update?
    create?
  end

  def destroy?
    create? &&
      @record.feedbacks == [] &&
      @record.elected_id.nil?
  end
end
