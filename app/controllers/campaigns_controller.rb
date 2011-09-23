class CampaignsController < ApplicationController

def create
	ShopifyAPI::Base.site = session[:shopify].site if session[:shopify]
	shopify = ShopifyAPI::Shop.current
	@shop = Shop.find_by_shopify_id(shopify.id)
	@old_campaign = Campaign.where(:store_id => @shop.id, :active => true)
	if @old_campaign.last
				@old_campaign.last.update_attributes(:active => false)
				@old_campaign.last.save
	end
	@campaign = Campaign.new(params[:campaign])
	if @campaign.save
		    flash[:notice] = "New campaign added."
      		redirect_to root_path
    else
    	flash[:error] = "Something went wrong! Please try again."
      	redirect_to root_path
	end
end
