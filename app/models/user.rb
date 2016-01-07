class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  include DeviseTokenAuth::Concerns::User

  validates_presence_of :name, :lastname, :birth_year, :city
  validate :role?


  private

  def role?
    employer.blank? && employee.blank? &&
      errors.add(:base, 'Specify a role.')
    employer == true && employee == true &&
      errors.add(:base, "can't have two roles at the same time.")
  end
end
