source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "rails", "~> 7.0.8"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem 'geocoder'
gem 'carrierwave'
# Cloudinary
gem "cloudinary"
gem "pg_search"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"


gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
gem "bootsnap", require: false
gem "sassc-rails"
gem "devise"
gem 'faker'
gem "bootstrap", "~> 5.3"
gem "autoprefixer-rails"
gem "font-awesome-sass", "~> 6.1"
gem "simple_form", github: "heartcombo/simple_form"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
  gem "pry-byebug"
end

group :test do
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 6.0.0'
  gem 'rubocop-capybara'
  gem 'rubocop-rspec'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 5.0' # provides RSpec one-liners to test common Rails functionality
  gem 'simplecov', require: false
  gem 'warden'
  gem 'warden-rspec-rails'
  gem 'webdrivers'
  gem 'rails-controller-testing'
end
