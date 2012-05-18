Bookstash::Application.configure do
  config.mongoid.logger = Logger.new(File.join(Rails.root, 'log', "#{Rails.env}-mongoid.log"), :debug)
  config.mongoid.preload_models = false
  config.mongoid.persist_in_safe_mode = true
  config.max_retries_on_connection_failure = 2
end
