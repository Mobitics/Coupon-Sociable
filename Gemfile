source 'http://rubygems.org'

gem 'rails', '3.1.0'
gem 'shopify_app'
gem 'shopify_api'
gem 'omniauth', :git => 'git://github.com/intridea/omniauth.git' , :tag => 'v0.3.0.rc3'
gem 'hoe', '~> 1.5.1'
gem 'twitter'
gem 'faraday'
gem 'fb_graph'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

group :production do
  gem 'pg'
end
group :development, :test do
  gem 'sqlite3'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end
