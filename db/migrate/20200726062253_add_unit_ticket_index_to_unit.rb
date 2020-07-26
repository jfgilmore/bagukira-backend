class AddUnitTicketIndexToUnit < ActiveRecord::Migration[6.0]
  def change
    add_column :units, :ticket_num, :integer, default: 0
    add_column :tickets, :ticket_num, :integer
  end
end
