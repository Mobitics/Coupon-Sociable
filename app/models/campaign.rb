class Campaign < ActiveRecord::Base

attr_accessible :coupon_code, :active, :store_id

before_create :set_defaults

private
	def set_defaults
		shopify = ShopifyAPI::Shop.current
		shop = Shop.find_by_shopify_id(shopify.id)
		self.active = true
		self.store_id = shop.id
	end

end
