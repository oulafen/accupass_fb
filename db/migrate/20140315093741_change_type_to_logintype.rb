class ChangeTypeToLogintype < ActiveRecord::Migration
  def change
    remove_column :users, :type
    add_column :users, :login_type, :string, :default=>'user'
  end
end
