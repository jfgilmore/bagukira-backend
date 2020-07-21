class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :subject
      t.integer :status
      t.string :opened_by
      t.string :closed_by
      t.string :description
      t.references :unit

      t.timestamps
    end
  end
end
