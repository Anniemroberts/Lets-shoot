# uri = URI.parse(ENV["REDISTOGO_URL"] || "redis://localhost:6379/" )
# REDIS = Redis.new(:host => localhost, :port => uri.port, :password => uri.password)s

$redis = Redis.new(:host => 'localhost', :port => 6379)
#$redis = Redis.new(:url => "redis://:127.0.0.1:6379")

if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    if forked
      $redis.client.disconnect
      $redis = Redis.new(:host => 'localhost', :port => 6379)
    end
  end
end
