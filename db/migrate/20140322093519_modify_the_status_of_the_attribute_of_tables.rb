class ModifyTheStatusOfTheAttributeOfTables < ActiveRecord::Migration
  def change
    remove_column :activities, :name
    add_column :activities,  :active_status, :string
    add_column :activities,  :active_name, :string
  end
end
