class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :coupon_code
      t.boolean :active
      t.integer :store_id

      t.timestamps
    end
  end
end
