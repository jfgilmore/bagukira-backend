class UsersController < ApplicationController
  before_action :authenticate_user, only: %i[update destroy] # index show
  # before_action :set_user, only: %i[show update destroy]

  # Default ordered by email
  # def index
  #   users = User.order(email: :desc).all
  #   render json: { users: users }, status: :ok
  # end

  # def show
  #   render json: @user, status: :ok
  # end

  def create
    user = User.new(user_params)
    if user.save
      BaguMailMailer.with(user: user).user_created_mail.deliver_now
      render json: { success: 'user created' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if current_user.update(user_params)
      BaguMailMailer.with(user: current_user).user_updated_mail.deliver_now
      render json: {}, status: :no_content
    else
      render json: { errors: current_user.errors.full_messages }, status: :internal_server_error
    end
  end

  def destroy
    BaguMailMailer.with(user: current_user).user_destroyed_mail.deliver_now
    render json: {}, status: :no_content if current_user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  # def set_user
  #   @user = User.find(params[:id])
  # end
end
