source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '4.1.6'
gem 'rails-api'
gem 'pg'
gem 'rack-cors', require: 'rack/cors'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.1.2'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
gem 'unicorn'

gem 'cancan'

gem 'fb_graph'

group :test, :development do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'its'
  gem 'fuubar'
end

group :test do
  gem 'shoulda-matchers'
end

group :production do
  gem 'rails_12factor' #Heroku
  gem 'newrelic_rpm'
end

