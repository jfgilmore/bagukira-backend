class UnitsController < ApplicationController
  before_action :set_unit, only: %i[show update destroy]
  before_action :set_user, only: %i[index create]

  def index
    units = if params[:search]
              @user.units.search(params).order(:at_time)
            elsif params[:user]
              @user.units
            end
    render json: { units: units }, status: :ok
  end

  def show
    render json: @unit, status: :ok
  end

  def create
    unit = @user.units.new(unit_params)
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
    params.require(:unit).permit(:name, :unit_hash, :user_id, :unit_type, :id)
  end

  def user_params
    params.require(:user).permit(:id, :jwt)
  end

  def set_unit
    unit_id = params[:id] || unit_params[:id]
    @unit = Unit.find_by!(unit_hash: unit_id)
  end

  def set_user
    @user = User.find(user_params[:id])
  end

  # create unit hashes for lookup by non users
  def project_hash(unit)
    p unit._read_attribute('id')
    hash = Digest::SHA256.hexdigest("#{unit.user_id}:#{unit.id}")
    unit.update({ unit_hash: hash })
  end
end
