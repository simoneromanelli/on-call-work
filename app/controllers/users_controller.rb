class UsersController < RestrictedController

  before_action only: [:index, :create] { authorize_class User}
  before_action :set_user, only: [:show, :update, :destroy]
  before_action only: [:show, :update, :destroy] { authorize_instace @user}

  def_param_group :user do
    param :user, Hash do
      param :name, String, 'Name of the user', required: true
      param :lastname, String, 'Lastname of of the user', required: true
      param :birth_year, Integer, "User's birth year", required: true
      param :city, String, "User's city", required: true
      param :employer, [true, false],
            'Employer flag. Required if employee is blank'
      param :employee, [true, false],
            'Employee flag. Required if employer is blank'
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
    if @policy_error
      render status: 401, json: { errors: [@policy_error] }
    else
      render json: @user
    end
  end

  api! 'Create a new User'
  param_group :user
  def create
    @user = User.new user_params
    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  api! 'Update a user'
  param :id, Integer, desc: 'User id'
  param_group :user
  def update
    if @policy_error
      render status: 401, json: { errors: [@policy_error] }
    elsif @user.update(user_params)
      render json: @user
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  api! 'Delete user'
  param :id, Integer, desc: 'User id'
  def destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      [
        :email,
        :password,
        :name,
        :lastname,
        :birth_year,
        :city,
        :employer,
        :employee
      ]
    )
  end
end
