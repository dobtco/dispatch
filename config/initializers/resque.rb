require 'resque/server'

Resque.redis = "#{ENV['REDIS_URL'] || ENV['BOXEN_REDIS_URL']}0/resque"

unless Rails.env.development?
  Resque::Server.use(Rack::Auth::Basic) do |_, password|
    ENV['RESQUE_ADMIN_PASSWORD'].present? &&
    password.presence == ENV['RESQUE_ADMIN_PASSWORD']
  end
end

# Fork as per https://devcenter.heroku.com/articles/forked-pg-connections#resque-ruby-queuing
Resque.before_fork do
  defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!
end

Resque.after_fork do
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end
