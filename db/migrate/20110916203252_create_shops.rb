class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.integer :shopify_id
      t.string :coupon_code
      t.boolean :multiple_use
      t.string :update_text
      t.boolean :accepts_emails

      t.timestamps
    end
  end
end
