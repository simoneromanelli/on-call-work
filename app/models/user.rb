class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  include DeviseTokenAuth::Concerns::User

  validates :email, uniqueness: true
  validates :email, :name, :lastname, :birth_year, :city, presence: true
  validate :role?

  after_create :send_confirmation_instructions
  private

  def role?
    employer.blank? && employee.blank? &&
      errors.add(:base, 'Specify a role.')
    employer == true && employee == true &&
      errors.add(:base, "can't have two roles at the same time.")
  end
end
