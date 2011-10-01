source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'


gem 'has_scope'
gem 'inherited_resources'
gem 'kaminari'

gem 'newrelic_rpm'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

gem 'pg'
# Use unicorn as the web server


# Deploy with Capistrano
# gem 'capistrano'

gem 'dalli'

# To use debugger
group :development, :test do
  gem 'thin'
  gem 'ruby-debug19', :require => 'ruby-debug'
end


group :production do 
  gem 'unicorn'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end

gem "schema_plus", :git => 'git://github.com/DohMoose/schema_plus.git' 
