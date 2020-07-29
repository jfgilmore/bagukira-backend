class TicketsController < ApplicationController
  before_action :set_unit
  before_action :set_ticket, only: %i[show update destroy]
  before_action :increment_ticket_num, only: :create

  # GET /units/:unit_hash/tickets
  # Return a list of bugs sorted by status and date
  def index
    tickets = @unit.tickets
    render json: { count: (@unit.tickets_count || 0), tickets: tickets }, status: :ok
  end

  # GET /units/:unit_hash/tickets/:ticket_num
  def show
    render json: { count: 1, tickets: @ticket }, status: :ok
  end

  # POST /units/:unit_hash/tickets
  # Increments relative ticket number to allocate unique ticket id within
  # the parent unit namespace. Rolls back on failure to create.
  def create
    # ticket_num relative to unit added as before_create action\
    new_params = ticket_params.merge(ticket_num: @unit.ticket_num)
    @ticket = @unit.tickets.new(new_params)

    if @ticket.save
      render json: { tickets: @ticket }, status: :created
    else
      # rubocop:disable Rails/SkipsModelValidations
      @unit.decrement!(:ticket_num)
      # rubocop:enable Rails/SkipsModelValidations
      render json: { errors: @ticket.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT or PATCH /units/:unit_hash/tickets/:ticket_num
  def update
    if @ticket.update(ticket_params)
      render json: {}, status: :no_content
    else
      render json: { errors: @ticket.errors.full_messages }, status: :internal_server_error
    end
  end

  # DELETE /units/:unit_hash/tickets/:ticket_num
  def destroy
    @ticket.destroy
    render json: {}, status: :no_content
  end

  private

  # Set strong params
  def ticket_params
    params.require(:ticket).permit(:subject, :status, :opened_by, :unit_id, :description,
                                   :closed_by, :ticket_num, :severity)
  end

  # Set the parent unit of the ticket
  def set_unit
    @unit = Unit.find_by!(unit_hash: params[:unit_id])
  end

  # Retrieve the ticket
  def set_ticket
    @ticket = @unit.tickets.find_by!(ticket_num: params[:id])
  end

  # Generates ticket number unique to the unit to be applied to new tickets.
  def increment_ticket_num
    # rubocop:disable Rails/SkipsModelValidations
    @unit.increment!(:ticket_num)
    # rubocop:enable Rails/SkipsModelValidations
  end
end
