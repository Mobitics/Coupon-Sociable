class Notifier < ActionMailer::Base
  default :from => "hi@couponsociable.com"

  # send a signup email to the user, pass in the user object that contains the user's email address
  def post_email(to_email, user)
    mail( :to => to_email, 
          :subject => "#{user.name} posted to #{user.provider.capitalize} using Coupon Sociable!",
          :body => "#{user.name} posted to #{user.provider.capitalize} using Coupon Sociable!")
  end
end