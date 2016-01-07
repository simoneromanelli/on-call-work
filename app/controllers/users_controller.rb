class UsersController < RestrictedController

  def_param_group :user do
    param :user, Hash do
      param :name, String, 'Name of the user', required: true
      param :lastname, String, 'Lastname of of the user', required: true
      param :birth_year, Integer, "User's birth year", required: true
      param :city, String, "User's city", required: true
      param :employer, [true, false], 'User is an employer. Required if employee is blank'
      param :employee, [true, false],  'User is an employee. Required if employer is blank'
    end
  end

  skip_before_filter :authenticate_user!, only: [:create]

  api! 'List of Users'
  def index
    @users = User.all

    render json: @users
  end

  api! 'Get the user'
  param :id, Integer, desc: 'User id'
  def show
  end

  api! 'Create a new User'
  param_group :user
  def create
  end

  api! 'Update a user'
  param :id, Integer, desc: 'User id'
  param_group :user
  def update
  end

  api! 'Delete user'
  param :id, Integer, desc: 'User id'
  def destroy
  end

end
