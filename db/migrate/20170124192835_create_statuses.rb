class CreateStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :statuses do |t|
      t.integer :lead_id
      t.string :name
      t.text :notes
      t.datetime :date
      t.boolean :active

      t.timestamps
    end
    add_index :statuses, :lead_id
  end
end
