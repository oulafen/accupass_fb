class AddTypeToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :attribute
    add_column :users, :type, :string, :default=>'user'
  end
end
