class SessionsController < ApplicationController
def create
  auth = request.env["omniauth.auth"]
  provider = params["provider"]
  user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
  session[:user_id] = user.id
  redirect_to "/coupon/#{session[:current_shop]}", :notice => "Signed in!"
  session[:current_shop] = nil
end

def destroy
  session[:user_id] = nil
  redirect_to "/coupon/#{session[:current_shop]}", :notice => "Signed out!"
  session[:current_shop] = nil
end
end
