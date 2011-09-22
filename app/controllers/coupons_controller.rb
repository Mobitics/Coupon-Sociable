class CouponsController < ApplicationController
	skip_filter :ensure_merchant_has_paid
	def index
		@shop_id = params[:shop_id]
		session[:current_shop] = @shop_id
		@shop = Shop.find_by_shopify_id(@shop_id)
		render :layout => false
	end
	
	def status_update
		@shop = Shop.find_by_shopify_id(session[:current_shop])
		@post = Post.new
		if current_user.provider == "twitter"
			# set up for the Twitter gem
			Twitter.configure do |config|
				if Rails.env == "development"
  				config.consumer_key = "Oz3xNAgL2equQNBYkEWFw"
  				config.consumer_secret = "xC1CGmxCH0FvJbkxt1F3wWbcuc9EIH0ZFTUX0YJmLqA"
  				else
  				config.consumer_key = "VZNx04Rs1aP3qdvKccpxsg"
  				config.consumer_secret = "XfkcQM8UIab8bR7u9wnTqYbXjrVXv0tCSJJZTOZsMk"
  				end
  				
  				config.oauth_token = current_user.token
  				config.oauth_token_secret = current_user.secret
  			end
  			
  			# initialize a new Twitter client to post update  			
  			client = Twitter::Client.new
  			
  			# use the shop's update text to post to the customer's Twitter
  			client.update(@shop.update_text)
  			
  		elsif current_user.provider == "facebook"
  			if Rails.env == "development"
				 client = OAuth2::Client.new('224049387650906', 'e8e33bd125343a6107f7220f046b7203', :site => 'https://graph.facebook.com')
			else
				client = OAuth2::Client.new('157999927621589', 'b72e2c73b99ff5959c212461fd21b510', :site => 'https://graph.facebook.com', :ssl => {:ca_path => '/etc/ssl/certs'})
			end
			 
 			token = OAuth2::AccessToken.new(client, current_user.token)
 			
 			#post to Facebook
 			token.post('/me/feed', :message => @shop.update_text)
   		end
 		
 		# save the update
  		@post.update_attributes(:user_id => current_user.id)
  		@post.save
  		
  		# Check if the store would like to receive email
  		if @shop.accepts_emails
  			# if they do want to receive email, send them an email
  			Notifier.post_email(@shop.email, current_user).deliver
  		end
		
  		# redirect the user to show the coupon code
  		redirect_to show_coupon_path
  	end
  	
  	def show_coupon  		
  		# get the current shop object using the current_shop session
  		@shop = Shop.find_by_shopify_id(session[:current_shop])
  		
  		# used to display the coupon code in the view
  		@coupon_code = @shop.coupon_code
  		
  		# do not use the main layout
  		render :layout => false
  	end

end
