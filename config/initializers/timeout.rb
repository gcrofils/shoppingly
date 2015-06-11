begin
  require 'rack-timeout'
  Rack::Timeout.timeout = 20  # seconds
rescue LoadError
end
