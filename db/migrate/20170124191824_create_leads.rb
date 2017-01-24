class CreateLeads < ActiveRecord::Migration[5.0]
  def change
    create_table :leads do |t|
      t.integer :user_id
      t.string :name
      t.string :job_title
      t.string :company
      t.string :email
      t.string :phone
      t.text :notes
      t.datetime :last_action
      t.boolean :archive

      t.timestamps
    end
    add_index :leads, :user_id
  end
end
