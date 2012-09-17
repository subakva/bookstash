source 'https://rubygems.org'

gem 'rails', '~>3.2.0'

gem 'dropbox-sdk'
gem 'unicorn'
gem 'newrelic_rpm'

gem 'mongoid'
gem 'omniauth-dropbox'
# gem 'will_paginate_mongoid'
# gem 'bootstrap-will_paginate' # Bootstrap-compatible LinkRenderer for will_paginate

gem 'awesome_print'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'slim-rails'
  gem 'less-rails-bootstrap'
  gem 'less-rails-fontawesome'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platform => :ruby
  gem 'uglifier', '>= 1.0.3'
  gem 'jquery-rails'
end

group :test, :development do
  gem 'heroku'  # Deploy to heroku
  gem 'foreman' # Use foreman for managing processes

  # Include in development for rake tasks
  gem 'rspec-rails', '~> 2.10'
  gem 'simplecov', '~> 0.6.2'
  gem 'cane', '~> 1.3.0'

  # gem 'yard', '~> 0.7.5'
  # gem 'yard-tomdoc', '~> 0.4.0'
  # gem 'ruby-debug19', :require => 'ruby-debug'
end

group :test do
  gem 'capybara'
  gem 'capybara-webkit' # use a headless browser (required "brew install qt")
  gem 'launchy' # for save_and_open_page
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'mongoid-rspec'
end

group :development do
  gem 'powder'
  gem 'quiet_assets'
end
