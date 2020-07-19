class UsersController < ApplicationController
  before_action :set_user, only: %i[show update delete]

  def index
    users = User.all
    render json: { users: users }, status: 200
  end

  def show
    render json: @user, status: 200
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 200
    else
      render status: 500
    end
  end

  def update
    if @user.update(user_params)
      render json: @user, status: 204
    else
      render status: 500
    end
  end

  def delete
    render json: {}, status: :no_content if @user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
