class HomeController < ApplicationController
  
  around_filter :shopify_session, :except => 'welcome'
  
  def welcome
    current_host = "#{request.host}#{':' + request.port.to_s if request.port != 80}"
    @callback_url = "http://#{current_host}/login/finalize"
  end
  
  def index
	# Get the current shop in the database, or create a new entry if this is the first time the shop has logged in
   	shopify = ShopifyAPI::Shop.current
   	@shop = Shop.find_or_create_by_shopify_id(:shopify_id => shopify.id)
  end
  
end