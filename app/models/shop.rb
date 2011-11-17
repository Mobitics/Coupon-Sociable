class Shop < ActiveRecord::Base

attr_accessible :shopify_id, :coupon_code, :multiple_use, :update_text, :accepts_emails, :email

before_create :set_defaults

private
	def set_defaults
		shopify = ShopifyAPI::Shop.current
		self.multiple_use = false
		self.update_text = "I'm shopping at #{shopify.name} http://#{shopify.domain}"
		self.accepts_emails = true
		self.email = shopify.email
		self.name = shopify.name
	end
end
