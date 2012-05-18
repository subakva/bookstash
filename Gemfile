source 'https://rubygems.org'

gem 'rails', '~>3.2.0'
gem 'jquery-rails'
gem 'haml-rails'

gem 'dropbox-sdk'
gem 'unicorn'
gem 'newrelic_rpm'

gem 'mongoid'
gem 'bson_ext'
# gem 'will_paginate_mongoid'
# gem 'bootstrap-will_paginate' # Bootstrap-compatible LinkRenderer for will_paginate

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platform => :ruby
  gem 'uglifier', '>= 1.0.3'
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

  # Guard requirements
  if RUBY_PLATFORM =~ /darwin/i
    gem 'rb-fsevent'
    gem 'growl'
  end
  gem 'guard-rspec'

  gem 'spork'
  gem 'guard-spork'
end

# group :development do
#   gem 'powder'
# end
