class AddNameToShop < ActiveRecord::Migration
  def change
    add_column :shops, :name, :string
  end
end
