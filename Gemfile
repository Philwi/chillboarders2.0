source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2', '>= 6.0.2.2'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# translation stuff
gem 'rails-i18n', '~> 6.0.0' # For 6.0.0 or higher
gem 'devise'
gem 'devise-i18n'
gem 'friendly_id', '~> 5.2.4'
gem 'route_translator'
gem 'country_select'

# map stuff
gem 'leaflet-rails'
gem 'open_street_map'
gem 'geocoder'

# crawler stuff
gem "wombat"
gem 'watir-rails'
gem 'chromedriver-helper'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

gem "simple_form"
# gem "formular", github: "trailblazer/formular"
gem "dry-validation"
gem 'reform-rails'

gem "trailblazer", ">= 2.0.3"
gem "trailblazer-rails"
gem "trailblazer-cells"
gem "cells-rails"
gem "cells-slim"
gem "cells-erb"
gem "slim-rails"
gem 'material_icons'

gem 'bootstrap', '~> 4.4.1'
gem 'jquery-rails'

gem "aws-sdk-s3", require: false

# error-handling
gem 'honeybadger', '~> 4.0'

gem 'redis'

# for rss feeds and e-mails
gem 'activejob-retry'
gem 'delayed_job_active_record'
gem 'rss'
gem 'rufus-scheduler'

gem 'sitemap_generator'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-rails'
  gem 'i18n-tasks', '~> 0.9.31'

  gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'master'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "minitest-rails", "~> 6.0.0"
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  gem 'database_cleaner-active_record'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "stimulus_reflex", "~> 3.1"
