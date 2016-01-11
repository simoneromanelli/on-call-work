require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with email, password, name, surname, birth_year and city.' do 
    expect(build :user).to be_valid
  end

  it 'is invalid without name' do
    unamed_user = build(:user, name: nil)
    unamed_user.valid?
    expect(unamed_user.errors[:name]).to include "can't be blank"
  end

  it 'is invalid without lastname' do
    unamed_user = build(:user, lastname: nil)
    unamed_user.valid?
    expect(unamed_user.errors[:lastname]).to include "can't be blank"
  end

  it 'is invalid without birth year' do
    unborn_user = build(:user, birth_year: nil)
    unborn_user.valid?
    expect(unborn_user.errors[:birth_year]).to include "can't be blank"
  end

  it 'is invalid without a city' do
    homeless_user = build(:user, city: nil)
    homeless_user.valid?
    expect(homeless_user.errors[:city]).to include "can't be blank"
  end

  it 'is invalid without at least employer or employee' do
    user = build :unroled
    user.valid?
    expect(user.errors['base']).to include 'Specify a role.'
  end

  it 'is invalid if email is already taken' do
    create(:user, email: '123@stella.com')
    user_2 = build(:user, email: '123@stella.com')
    user_2.valid?
    expect(user_2.errors[:email]).to include 'has already been taken'
  end
  
  it "can't be emplyer and employee at the same time" do
    employer_and_employee = build :user, employee: true
    employer_and_employee.valid?
    expect(employer_and_employee.errors['base'])
      .to include "Can't have two roles at the same time."
  end
end
