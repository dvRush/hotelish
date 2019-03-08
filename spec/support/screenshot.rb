RSpec.configure do |config|
  errors_path = Rails.root.join('tmp', 'errors')

  config.before(:suite) do
    FileUtils.remove_dir errors_path, true
  end

  config.after(:each, type: :feature) do |example|
    if example.exception
      meta = example.metadata
      filename = File.basename(meta[:file_path])
      line_number = meta[:line_number]
      screenshot_name = "#{filename}-#{line_number}.png"
      screenshot_path = errors_path.join(screenshot_name)
      page.save_screenshot(screenshot_path, full: true)
      puts "Screenshot: #{screenshot_path}"
    end
  end
end
