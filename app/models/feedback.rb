class Feedback < ActiveRecord::Base

  validates :text, :rating, :writer, :subject, :work_offer, presence: true
  validate :editors_coherence

  belongs_to :subject, class_name: 'User', foreign_key: 'subject_id'
  belongs_to :writer, class_name: 'User', foreign_key: 'writer_id'
  belongs_to :work_offer, class_name: 'WorkOffer', foreign_key: 'work_offer_id'

  private

  def editors_coherence
    subject_id == writer_id && errors
      .add(:base, 'Writer and subject must be different users')
  end
end
