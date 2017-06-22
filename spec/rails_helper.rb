ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'
require 'devise'
Dir[Rails.root.join('spec/support/*.rb')].each { |f| require f }

include Warden::Test::Helpers

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
end

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include ActiveSupport::Testing::TimeHelpers
  config.include FactoryGirl::Syntax::Methods
  config.include Warden::Test::Helpers
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  I18n.enforce_available_locales = false
  config.order = 'random'
  config.render_views = true
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
end
