class UnitsController < ApplicationController
  before_action :set_unit, only: %i[show update destroy]

  def index
    units = Unit.all
    render json: { units: units }, status: :ok
  end

  def show
    render json: @unit, status: :ok
  end

  def create
    unit = Unit.new(unit_params)
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
    params.require(:unit).permit(:unit_hash, :name, :user_id, :unit_type)
  end

  def set_unit
    @unit = Unit.find_by!(unit_hash: params[:id])
  end

  # create unit hashes for lookup by non users
  def project_hash(unit)
    hash = Digest::SHA256.hexdigest("#{unit.user_id}:#{unit.id}")
    unit.update({ unit_hash: hash })
  end
end
