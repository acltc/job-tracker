class AddDefaultToArchiveAttributeInLeads < ActiveRecord::Migration[5.0]
  def up
    change_column :leads, :archive, :boolean, :default => false
  end

  def down
    change_column :leads, :archive, :boolean, :default => nil
  end
end
