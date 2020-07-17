RSpec.configure do |config|
  # Clear the entire database is cleared before running any tests
  config.before(:suite) { DatabaseCleaner.clean_with(:truncation) }

  # The default recommended strategy to use
  config.before(:each) { DatabaseCleaner.strategy = :transaction }

  # These two settings tell DatabaseCleaner to hook into the start and end of the tests.
  config.before(:each) { DatabaseCleaner.start }

  config.after(:each) { DatabaseCleaner.clean }
end
