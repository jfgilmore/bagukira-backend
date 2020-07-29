class StatusController < ApplicationController
  before_action :authenticate_user

  def index
    render json: { message: 'logged in' }, status: :continue if current_user
  end

  def user
    render json: { user: current_user.email }, status: :ok if current_user
  end
end
