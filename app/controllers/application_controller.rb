class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :posted, :get_facebook_count, :get_twitter_count

  before_filter :ensure_merchant_has_paid

  
  if Rails.env == "development"
  	OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
  end
  
  def ensure_merchant_has_paid
  	ShopifyAPI::Base.site = session[:shopify].site if session[:shopify]
  	shopify_session do
   		unless ShopifyAPI::RecurringApplicationCharge.current
   			shop = ShopifyAPI::Shop.current
      		if Rails.env == "development"
      			charge = ShopifyAPI::RecurringApplicationCharge.create(:name => "Basic plan", :price => 5.00, :return_url => 'http://localhost:3000/charges/confirm', :trial_days => 30, :test => true)
      		else
      			if current_shop.url == "luxedesignerhandbags.myshopify.com"
      				charge = ShopifyAPI::RecurringApplicationCharge.create(:name => "Mobitics plan", :price => 1.00, :return_url => 'http://couponsociable.com/charges/confirm', :trial_days => 30, :test => true)
				elsif shop.plan_name == "development"
					charge = ShopifyAPI::RecurringApplicationCharge.create(:name => "Basic plan", :price => 5.00, :return_url => 'http://couponsociable.com/charges/confirm', :trial_days => 30, :test => true)
				else
					charge = ShopifyAPI::RecurringApplicationCharge.create(:name => "Basic plan", :price => 5.00, :return_url => 'http://couponsociable.com/charges/confirm', :trial_days => 30)
				end
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
	posted = false
 	@posts = Post.where(:user_id => current_user) if current_user
 	@posts.each do |post|
 		campaign = Campaign.find(post.campaign_id)
 		if campaign.active == true
			posted = true
		end
	end
	
	return posted
end

def get_facebook_count(campaign)
	all_posts = Post.where(:campaign_id => campaign.id)
	facebook_posts = 0
	all_posts.each do |post|
		user = User.find(post.user_id)
		if user.provider == 'facebook'
			facebook_posts += 1
		end
	end
	
	return facebook_posts
end

def get_twitter_count(campaign)
	all_posts = Post.where(:campaign_id => campaign.id)
	twitter_posts = 0
	all_posts.each do |post|
		user = User.find(post.user_id)
		if user.provider == 'twitter'
			twitter_posts += 1
		end
	end
	
	return twitter_posts
end

end
