class AddTheBmnumAndStatusForTheShow < ActiveRecord::Migration
  def change
    remove_column :shows, :created_at
    remove_column :shows, :updated_at
    add_column :shows,  :bm_num, :string
    add_column :shows,  :bid_status, :string
  end
end
