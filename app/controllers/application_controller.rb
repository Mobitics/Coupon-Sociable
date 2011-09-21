class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :posted
  
  if Rails.env == "development"
  	OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
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
