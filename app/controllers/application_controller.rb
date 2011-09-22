class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :posted

  before_filter :ensure_merchant_has_paid

  
  if Rails.env == "development"
  	OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
  end
  
  def ensure_merchant_has_paid
  	ShopifyAPI::Base.site = session[:shopify].site if session[:shopify]
  	shopify_session do
   		unless ShopifyAPI::RecurringApplicationCharge.current
      		if Rails.env == "development"
      			charge = ShopifyAPI::RecurringApplicationCharge.create(:name => "Basic plan", :price => 5.00, :return_url => 'http://localhost:3000/charges/confirm', :trial_days => 30, :test => true)
      		else
      			#TODO: on deploy, change this so that test != true
				charge = ShopifyAPI::RecurringApplicationCharge.create(:name => "Basic plan", :price => 5.00, :return_url => 'https://coupon-sociable.heroku.com/charges/confirm', :trial_days => 30, :test => true)
			end
			
			redirect_to ShopifyAPI::RecurringApplicationCharge.pending.first.confirmation_url 
    	end
    end
  end


private

def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
end

def posted
 	@post = Post.find_by_user_id(current_user) if current_user
	if @post
		return true
	else
		return false
	end
end

end
