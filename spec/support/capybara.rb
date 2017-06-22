require 'capybara/rspec'
require 'capybara/email/rspec'
require 'capybara/poltergeist'

module Support
  # Prevents requests from hitting the Rails app after the test has finished.
  class CapybaraRequestBlockerMiddleware
    # assignment to initialized instance variables is thread safe in Ruby
    @enabled = false

    class << self
      def enabled?
        @enabled
      end

      def enable!
        @enabled = true
      end

      def disable!
        @enabled = false
      end
    end

    def initialize(app)
      @app = app
    end

    def call(env)
      if self.class.enabled?
        @app.call(env)
      else
        [200, {}, ['Request blocked by block middleware']]
      end
    end
  end
end

RSpec.configure do |config|
  config.before(:each) do
    Support::CapybaraRequestBlockerMiddleware.enable!
  end
  config.before(:each, js: true) do
    Capybara.page.driver.resize('1920', '1080')
  end
  config.after(:each) do
    clear_emails if is_a?(Capybara::Email::DSL)
    Support::CapybaraRequestBlockerMiddleware.disable!
    Capybara.reset_sessions!
  end
end

Capybara.app = Support::CapybaraRequestBlockerMiddleware.new(Rails.application)
Capybara.javascript_driver = :poltergeist
Capybara.default_max_wait_time = 5

Capybara.configure do |config|
  config.raise_server_errors = false
end

Capybara.register_driver :selenium do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile['focusmanager.testmode'] = true
  Capybara::Selenium::Driver.new(app, profile: profile)
end
