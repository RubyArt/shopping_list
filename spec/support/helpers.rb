Dir[Rails.root.join('spec/support/helpers/*.rb')].each { |file| require file }

RSpec.configure do |config|
  config.include Support::Helpers, type: :feature
end
