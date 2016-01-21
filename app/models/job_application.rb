#
class JobApplication < ActiveRecord::Base
  validates :user_id, :work_offer, presence: true
  validate :user_coherence

  belongs_to :user
  belongs_to :work_offer

  private

  def user_coherence
    !User.find(user_id).employee? && errors
      .add(:base, 'Employee only can apply to a work offer')
  end
end
