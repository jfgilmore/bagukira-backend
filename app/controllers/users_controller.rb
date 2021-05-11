# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user, only: %i[index show update destroy]
  before_action :authorized, only: [:auto_login]
  before_action :set_user, only: %i[show update destroy]

  # Default ordered by email
  def index
    users = User.select(:email, :id).order(email: :desc).all
    render json: { users: users }, status: :ok
  end

  def show
    render json: @user, status: :ok
  end

  def login
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }
    else
      render json: { error: 'Invalid username or password' }
    end
  end

  def auto_login
    render json: @user
  end

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
    return unless @user.destroy

    BaguMailMailer.with(user: @user).user_destroyed_mail.deliver_now
    render json: {}, status: :no_content
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
