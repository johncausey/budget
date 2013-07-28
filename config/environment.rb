# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Budget::Application.initialize!

unless Rails.env.test?
  ActionMailer::Base.smtp_settings = {
    :user_name => 'halimede',
    :password => 'jenny8675309',
    :domain => 'rainybudget.com',
    :address => 'smtp.sendgrid.net',
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
  }
end
