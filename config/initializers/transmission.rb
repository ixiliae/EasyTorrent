# config/initializers/transmission.rb
TRANSMISSION_RPC_URL = ENV.fetch('TRANSMISSION_RPC_URL') { raise "TRANSMISSION_RPC_URL environment variable is not set" }