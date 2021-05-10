# frozen_string_literal: true

RSpec.configure do |config|
  # Clear the entire database is cleared before running any tests
  config.before(:suite) { DatabaseCleaner.clean_with(:truncation) }

  # The default recommended strategy to use
  config.before { DatabaseCleaner.strategy = :transaction }

  # These two settings tell DatabaseCleaner to hook into the start and end of the tests.
  config.before { DatabaseCleaner.start }

  config.after { DatabaseCleaner.clean }
end
