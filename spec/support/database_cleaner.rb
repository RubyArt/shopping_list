require 'database_cleaner'

RSpec.configure do |config|
  EXCLUDE_TABLES = %w[spatial_ref_sys].freeze

  config.before(:suite) do
    DatabaseCleaner.clean_with(:deletion, except: EXCLUDE_TABLES)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = RSpec.current_example.metadata.fetch(:database_cleaner, :transaction)
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation, { except: EXCLUDE_TABLES }
  end

  config.before(:each) do
    DatabaseCleaner.start
    ActionMailer::Base.deliveries.clear
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
