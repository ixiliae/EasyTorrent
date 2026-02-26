# config/initializers/authentication.rb
APP_USERNAME = ENV.fetch('APP_USERNAME') { raise "APP_USERNAME environment variable is not set" }
APP_PASSWORD = ENV.fetch('APP_PASSWORD') { raise "APP_PASSWORD environment variable is not set" }