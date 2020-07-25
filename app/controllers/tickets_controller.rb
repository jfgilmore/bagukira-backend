class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[index show create update destroy]

  def index
    # puts @unit
    tickets = @unit.tickets.all
    # else
    #   []
    # # else
    # #   Ticket.all
    # end
    render json: { tickets:  tickets }, status: :ok
  end

  def show
    render json: @ticket, status: :ok
  end

  def create
    @ticket = @unit.tickets.new(ticket_params)
    # Ticket number, unique to unit(project)
    @ticket.number = @unit.tickets.last
    if @ticket.save
      render json: { tickets: @ticket }, status: :created
    else
      render json: { errors: @ticket.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @ticket.update(ticket_params)
      render status: :no_content
    else
      render json: { errors: @ticket.errors.full_messages }, status: :internal_server_error
    end
  end

  def destroy
    @ticket.destroy
    render json: {}, status: :no_content
  end

  private

  def ticket_params
    params.require(:ticket).permit(:id, :subject, :status, :opened_by, :description, :unit, :unit_id, :closed_by)
  end

  def set_ticket
    @unit = Unit.find(params[:unit_id])
    @ticket = @unit.tickets.find(params[:id]) || Ticket.find(params[:id])
  end
end
