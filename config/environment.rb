# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Budget::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => ENV['BUDGET_SENDGRID_USERNAME'],
  :password => ENV['BUDGET_SENDGRID_PASSWORD'],
  :domain => ENV['BUDGET_SENDGRID_DOMAIN'],
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
