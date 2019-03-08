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
      ]
    }
  )

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: capabilities
  )
end

Capybara.javascript_driver = :chrome
