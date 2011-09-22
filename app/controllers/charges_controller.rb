class ChargesController < ApplicationController
  around_filter :shopify_session
  skip_filter :ensure_merchant_has_paid
  
  def confirm
    ShopifyAPI::RecurringApplicationCharge.find(params[:charge_id]).activate
    redirect_to root_url
  end
end