class HomeController < ApplicationController
  
  around_filter :shopify_session, :except => 'welcome'
  skip_filter :ensure_merchant_has_paid, :except => 'index'
  
  def welcome
    current_host = "#{request.host}#{':' + request.port.to_s if request.port != 80}"
    @callback_url = "http://#{current_host}/login/finalize"
  end
  
  def index
	# Get the current shop in the database, or create a new entry if this is the first time the shop has logged in
   	shopify = ShopifyAPI::Shop.current
   	if shopify.empty?
   		redirect_to "/login"
   	end
   	@shop = Shop.find_or_create_by_shopify_id(:shopify_id => shopify.id)
   	@current_campaign = Campaign.where(:store_id => @shop.id, :active => true)
   	@campaign = Campaign.new
   	@all_campaigns = Campaign.where(:store_id => @shop.id)
   	
   	if Rails.env == "development"
   	
 @code_line_1 = "<SCRIPT TYPE='text/javascript'>"
 @code_line_2 = "<!--"
 @code_line_3 = "function popup(mylink, windowname)\n
					{\n
						if (! window.focus)return true;\n
						var href;\n
						if (typeof(mylink) == 'string')\n
						href=mylink;\n
						else\n
   						href=mylink.href;\n
					window.open(href, windowname, 'width=400,height=200,scrollbars=yes');\n
					return false;\n
					}"
 @code_line_4 = "//-->"
 @code_line_5 =	"</SCRIPT>"
 @code_line_6	= "<A HREF=\"http://localhost:3000/coupon/#{@shop.shopify_id}\" 
   onClick=\"return popup(this, 'notes')\"><IMG SRC=\"http://localhost:3000/assets/Coupon-Sociable.png\" /></A>"
   
   else 

 @code_line_1 = "<SCRIPT TYPE='text/javascript'>"
 @code_line_2 = "<!--"
 @code_line_3 = "function popup(mylink, windowname)\n
					{\n
						if (! window.focus)return true;\n
						var href;\n
						if (typeof(mylink) == 'string')\n
						href=mylink;\n
						else\n
   						href=mylink.href;\n
					window.open(href, windowname, 'width=400,height=200,scrollbars=yes');\n
					return false;\n
					}"
 @code_line_4 = "//-->"
 @code_line_5 =	"</SCRIPT>"
 @code_line_6	= "<A HREF=\"http://couponsociable.com/coupon/#{@shop.shopify_id}\" 
   onClick=\"return popup(this, 'notes')\"><IMG SRC=\"http://couponsociable.com/assets/Coupon-Sociable.png\" /></A>"
   
   end
  end
  
end