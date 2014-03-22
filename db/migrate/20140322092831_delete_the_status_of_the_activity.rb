class DeleteTheStatusOfTheActivity < ActiveRecord::Migration
  def change
    remove_column :activities, :status

  end
end
