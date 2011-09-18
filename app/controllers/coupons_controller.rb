class CouponsController < ApplicationController

	def index
		@shop_id = params[:shop_id]
		render :layout => false
	end

end
