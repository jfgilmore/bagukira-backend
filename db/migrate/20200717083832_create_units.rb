class CreateUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :units do |t|
      t.string :name, null: false
      t.integer :unit_type, null: false, default: 0
      t.integer :tickets_count
      t.string :unit_hash
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
