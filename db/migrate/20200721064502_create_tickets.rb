class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :subject, null: false
      t.integer :status, null: false, default: 1
      t.string :opened_by, null: false
      t.string :closed_by
      t.string :description, default: ''
      t.string :unit_id, foreign_key: true, null: false

      t.timestamps
    end
  end
end
