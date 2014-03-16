include Warden::Test::Helpers
Warden.test_mode!

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include Devise::TestHelpers, type: :view
end