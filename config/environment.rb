# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
CouponSociable::Application.initialize!


# mailer settings
ActionMailer::Base.smtp_settings = {
  :user_name => "jburdeezy",
  :password => "6EXxgyWNTT7ugD",
  :domain => "justinburdett.com",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}