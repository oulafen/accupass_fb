class ChangeAttributeInUsers < ActiveRecord::Migration
  def change
    change_column :users, :attribute, :string, :default=>'user'
  end
end
