RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.orm = "mongoid"
  end

  config.before(:each) do
    # Clean before the spec rather than after so that you can inspect the database after running a spec.
    DatabaseCleaner.clean
  end
end
