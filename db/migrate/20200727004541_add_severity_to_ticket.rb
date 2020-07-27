class AddSeverityToTicket < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :severity, :integer, null: false, default: 1
  end
end
