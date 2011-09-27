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
   	@shop = Shop.find_or_create_by_shopify_id(:shopify_id => shopify.id)
   	@current_campaign = Campaign.where(:store_id => @shop.id, :active => true)
   	@campaign = Campaign.new
   	@all_campaigns = Campaign.where(:store_id => @shop.id)
   	
   	if Rails.env == "development"
   	
   	@code = "<SCRIPT TYPE='text/javascript'>
<!--
function popup(mylink, windowname)
{
if (! window.focus)return true;
var href;
if (typeof(mylink) == 'string')
   href=mylink;
else
   href=mylink.href;
window.open(href, windowname, 'width=400,height=200,scrollbars=yes');
return false;
}
//-->
</SCRIPT>
<A 
   HREF='http://localhost:3000/coupon/#{@shop.shopify_id}' 
   onClick='return popup(this, 'notes')'>Post this to Facebook or Twitter and get a discount!</A>"
   
   else 

	@code = '<SCRIPT TYPE="text/javascript">
<!--
function popup(mylink, windowname)
{
if (! window.focus)return true;
var href;
if (typeof(mylink) == \'string\')
   href=mylink;
else
   href=mylink.href;
window.open(href, windowname, \'width=400,height=200,scrollbars=yes\');
return false;
}
//-->
</SCRIPT>

<A 
   HREF="http://localhost:3000/coupon/977102" 
   onClick="return popup(this, \'notes\')">Post to Twitter or Facebook and get a discount!</A>'
   end
  end
  
end