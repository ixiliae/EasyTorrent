# config/initializers/rack_attack.rb

class Rack::Attack
  # Limit all requests to 60 per minute per IP
  throttle('req/ip', limit: 60, period: 1.minute) do |req|
    req.ip
  end

  # Stricter limit on torrent-add (10 per minute per IP)
  throttle('add_torrent/ip', limit: 10, period: 1.minute) do |req|
    req.ip if req.path == '/add_torrent' && req.post?
  end

  # Return 429 with a plain-text body when throttled
  self.throttled_responder = lambda do |_env|
    [429, { 'Content-Type' => 'text/plain' }, ["Trop de requêtes. Veuillez réessayer dans un moment.\n"]]
  end
end
