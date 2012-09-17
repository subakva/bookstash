Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer if ['development', 'test'].include?(Rails.env)
  provider :dropbox, DROPBOX_CONSUMER_KEY, DROPBOX_CONSUMER_SECRET
end
