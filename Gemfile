source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Development webserver
gem 'thin'

# Control authorization through the site
gem 'cancan'

# Use rspec as the testing framework
group :test, :development do
  gem 'rspec-rails' # Rspec BDD
  gem 'database_cleaner' # Cleans database after each test unit
  gem 'guard-rspec' # Run tests automatically after touching a file under it's suite
  gem 'capybara' # 3rd Party testing framework
  gem 'selenium-webdriver' # Webdriver for capybara to test js functions
end

# Test environment setup
group :test do
  gem 'factory_girl_rails', '4.2.1' # Factories to replace fixtures, used in generating objects for testing
end

# Use pg as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use foundation for styling and base css
gem 'zurb-foundation'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Use jquery UI library
gem 'jquery-ui-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
