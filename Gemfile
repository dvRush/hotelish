source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '~> 6.0.3'
gem 'pg'
gem 'puma', '~> 4.3.8'

gem 'devise'
gem 'draper'
gem 'activeadmin'
gem 'activeadmin_dynamic_fields'
gem 'paranoia'
gem 'exception_notification'

gem 'sass-rails', '~> 6.0'
gem 'uglifier', '>= 4.2.0'

gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.10'

gem 'bootsnap', '>= 1.4.6', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
end

group :development do
  gem 'web-console', '>= 4.0.1'
  gem 'listen', '~> 3.2.1'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 3.31.0'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
