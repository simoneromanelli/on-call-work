class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  include DeviseTokenAuth::Concerns::User

  validates :email, uniqueness: true
  validates :email, :name, :lastname, :birth_year, :city, presence: true
  validate :role_coherence

  after_create :send_confirmation_instructions

  has_many :feedbacks, class_name: 'Feedback', foreign_key: 'subject_id'
  has_many :given_feedbacks, class_name: 'Feedback', foreign_key: 'writer_id'
  has_many :work_offers, class_name: 'WorkOffer', foreign_key: 'bidder_id'
  has_many :jobs, class_name: 'WorkOffer', foreign_key: 'elected_id'

  private

  def role_coherence
    employer.blank? && employee.blank? &&
      errors.add(:base, 'Specify a role.')
    employer == true && employee == true &&
      errors.add(:base, "Can't have two roles at the same time.")
  end
end
