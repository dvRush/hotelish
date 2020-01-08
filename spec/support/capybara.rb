require 'selenium-webdriver'
require 'chromedriver/helper'

Capybara.server = :puma, { Silent: true }

Capybara.register_driver :chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: {
      args: %w[
        no-sandbox
        headless
        disable-popup-blocking
        disable-gpu
        window-size=1366,768
        disable-dev-shm-usage
      ]
    }
  )

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: capabilities
  )
end

Selenium::WebDriver::Chrome.driver_path = '/usr/bin/chromedriver'

Capybara.javascript_driver = :chrome
