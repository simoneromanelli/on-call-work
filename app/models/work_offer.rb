class WorkOffer < ActiveRecord::Base

  validates :title,
            :description,
            :company_name,
            :date_time,
            :bidder_id,
            presence: true
  validate :users_coherence,
           :bidder_coherence,
           :elected_coerence,
           :date_coherence

  default_scope { where('date_time > ?', Time.now) }

  belongs_to :bidder, class_name: 'User', foreign_key: 'bidder_id'
  belongs_to :elected, class_name: 'User', foreign_key: 'elected_id'
  has_many :feedbacks

  private

  def users_coherence
    bidder_id == elected_id && errors
      .add(:base, 'bidder and elected can\'t the same user')
  end

  def bidder_coherence
    return unless bidder
    bidder.employee? && errors
      .add(:base, 'only employers can be work offer bidder')
  end

  def elected_coerence
    return unless elected
    elected.employer && errors
      .add(:base, 'only employees can be elected for a work offer')
  end

  def date_coherence
    return unless date_time
    date_time <= Time.now && errors
      .add(:date_time, 'can\'t be in the past')
  end
end
