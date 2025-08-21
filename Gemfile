# Gemfile

source "https://rubygems.org"
git_source(:github) { |repo_name| "https://github.com/#{repo_name}.git" }

ruby "3.1.2" # Ou la version de Ruby que vous utilisez

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.3"

# The asset pipeline for Rails.
gem "sprockets-rails"

# Use Puma as the app server
gem "puma", "~> 5.0"

# Use sqlite3 as the database for Active Record
gem "sqlite3", "~> 1.4"

# Gems pour notre application
gem 'httparty'
gem 'nokogiri'

# Build JSON APIs with Jbuilder
gem "jbuilder"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Use Sass to process CSS
gem "ms"

# Transpile app-like JavaScript. Read more: https://github.com/rails/jsbundling-rails
gem "jsbundling-rails"

# Minify CSS
gem "cssbundling-rails"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Use console on exceptions pages
  gem "web-console"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara"
  gem "selenium-webdriver"
end
gem 'httparty'