class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  
  if Rails.env == "development"
  	OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
  end

private

def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
end

end
