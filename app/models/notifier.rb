class Notifier < ActionMailer::Base
  default :from => "hi@couponsociable.com"

  # send a signup email to the user, pass in the user object that contains the user's email address
  def post_email(to_email, user)
  	if user.name && user.full_name
  		text = "#{user.full_name} (#{user.name}) posted to #{user.provider.capitalize} using Coupon Sociable!"
  	else
  		text = "#{user.full_name} posted to #{user.provider.capitalize} using Coupon Sociable!"
  	end
  	
    mail( :to => to_email, 
          :subject => text,
          :body => text)
  end
end