class Shop < ActiveRecord::Base

attr_accessible :shopify_id, :coupon_code, :multiple_use, :update_text, :accepts_emails

before_create :set_defaults

	def accepts_emails?
		return self.accepts_emails
	end
	
	def multiple_use?
		return self.multiple_use
	end

private
	def set_defaults
		shopify = ShopifyAPI::Shop.current
		self.multiple_use = false
		self.update_text = "I'm shopping at #{shopify.name} http://#{shopify.domain}"
		self.accepts_emails = true
	end
end
