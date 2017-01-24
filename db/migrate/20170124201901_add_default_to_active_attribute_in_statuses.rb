class AddDefaultToActiveAttributeInStatuses < ActiveRecord::Migration[5.0]
  def up
    change_column :statuses, :active, :boolean, :default => true
  end

  def down
    change_column :statuses, :active, :boolean, :default => nil
  end
end
