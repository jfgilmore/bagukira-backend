class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[show update destroy]

  def index
    tickets = Ticket.all
    render json: { tickets: tickets }, status: :ok
  end

  def show
    render json: @ticket, status: :ok
  end

  def create
    unit = Unit.find_by(unit_hash: ticket_params[:unit_hash])
    ticket = unit.tickets.new(ticket_params)
    puts ticket_params
    if ticket.save
      render json: { tickets: ticket }, status: :created
    else
      render json: { errors: ticket.errors.full_messages }, status: :unprocessable_entity
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
    params.require(:ticket).permit(:subject, :status, :opened_by, :description, :unit_hash, :closed_by)
  end

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
end
