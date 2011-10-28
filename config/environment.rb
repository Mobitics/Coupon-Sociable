# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
CouponSociable::Application.initialize!


# mailer settings
ActionMailer::Base.smtp_settings = {
  :user_name => "mobitics",
  :password => "mob1t1cS",
  :domain => "couponsociable.com",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}