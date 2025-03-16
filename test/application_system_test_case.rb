require "test_helper"

unless ENV["CI"]
  Capybara.server_host = "0.0.0.0"
  Capybara.app_host = "http://app:3000" # Use service name from docker-compose.yml
  Capybara.server_port = 3000
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  if ENV["CI"]
    driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]
  else
    driven_by :selenium, using: :chrome, screen_size: [ 1400, 1400 ], options: {
      browser: :remote,
      url: "http://chrome:4444/wd/hub"
    }
  end
end
