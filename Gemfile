source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'


gem 'has_scope'
gem 'inherited_resources'
gem 'kaminari'

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
group :development, :test do
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'sqlite3'
end


group :production do 
  gem 'pg'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end
