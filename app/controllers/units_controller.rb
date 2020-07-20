class UnitsController < ApplicationController
  before_action :set_unit, only: %i[show update delete]

  def index
    units = Unit.all
    render json: { units: units }, status: 200
  end

  def show
    render json: @unit, status: 200
  end

  def create
    unit = Unit.new(unit_params)
    if unit.save
      render json: unit, status: 201
    else
      render status: 500
    end
  end

  def update
    if @unit.update(unit_params)
      render json: @unit, status: 204
    else
      render status: 500
    end
  end

  def delete
    render json: {}, status: :no_content if @unit.destroy
  end

  private

  def unit_params
    params.require(:unit).permit(:name, :user, :unit_type)
  end

  def set_unit
    @unit = Unit.find(params[:id])
  end
end
