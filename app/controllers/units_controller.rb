class UnitsController < ApplicationController
  before_action :authenticate_user, only: %i[index invite create update destroy]
  before_action :set_unit, only: %i[show invite update destroy]
  # before_action :set_user, only: %i[index create]

  def index
    units = current_user.units # .order(status: :asc)
    render json: { count: (current_user.units_count || 0), units: units }, status: :ok
  end

  # Sends email invites to an array of users
  def invite
    @user = current_user
    list = unit_params[:invite_list]
    list.each do |address|
      BaguMailMailer.with({ user: @user, unit: @unit, email: address }).project_invite_mail.deliver_now
    end
    render json: {}, status: :no_content
  end

  def show
    render json: { count: 1, units: @unit }, status: :ok
  end

  def create
    unit = current_user.units.new(unit_params)
    if unit.save
      project_hash(unit)
      render json: { units: unit }, status: :created
    else
      render json: { errors: unit.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @unit.update(unit_params)
      render json: {}, status: :no_content
    else
      render json: { errors: @unit.errors.full_messages }, status: :internal_server_error
    end
  end

  def destroy
    render json: {}, status: :no_content if @unit.destroy
  end

  private

  def unit_params
    params.require(:unit).permit(:name, :unit_hash, :user_id, :unit_type, invite_list: [])
  end

  def set_unit
    @unit = Unit.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def project_hash(unit)
    # Get ticket postgres index
    query = 'SELECT MAX(id)  FROM units'
    new_unit_id = ActiveRecord::Base.connection.execute(query).values

    # Generate and store hash
    hash = Digest::SHA256.hexdigest("#{unit.user_id}:#{new_unit_id}")
    unit.update({ unit_hash: hash })
  end
end
