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
    expect(build :user, employer: nil).to be_invalid
  end
  it "can't be emplyer and employee at the same time" do
    employer_and_employee = build :user, employee: true
    expect(employer_and_employee).to be_invalid
  end
end
