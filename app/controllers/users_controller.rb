class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  def index
    users = User.order(email: :desc).all
    render json: { users: users }, status: :ok
  end

  def show
    render json: @user, status: :ok
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: { users: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: {}, status: :no_content
    else
      render json: { errors: @user.errors.full_messages }, status: :internal_server_error
    end
  end

  def destroy
    render json: {}, status: :no_content if @user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:email) # , :password
  end

  def set_user
    @user = User.find(params[:id])
  end
end
