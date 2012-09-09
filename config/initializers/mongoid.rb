Bookstash::Application.configure do
  Mongoid.logger = Logger.new(File.join(Rails.root, 'log', "#{Rails.env}-mongoid.log"), 'weekly')
  Moped.logger = Logger.new(File.join(Rails.root, 'log', "#{Rails.env}-moped.log"), 'weekly')
  config.max_retries_on_connection_failure = 2
end
