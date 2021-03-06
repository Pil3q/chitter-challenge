ENV['DATABASE'] = 'test'

require 'web_helpers'
require 'simplecov'
require 'simplecov-console'
require './app.rb'
require 'capybara'
require 'capybara/rspec'

Capybara.app = ChitterApp

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
  # Want a nice code coverage website? Uncomment this next line!
  # SimpleCov::Formatter::HTMLFormatter
])
SimpleCov.start


RSpec.configure do |config|
  config.after(:suite) do
    puts
    puts "\e[33mHave you considered running rubocop? It will help you improve your code!\e[0m"
    puts "\e[33mTry it now! Just run: rubocop\e[0m"
  end
  config.before(:each) do
  DatabaseConnection.query("TRUNCATE users, peeps")
  DatabaseConnection.query("INSERT INTO users(email, password, name, username) VALUES ('guest@guestland.on', 'test123', 'guest', 'guest')")
  end
end
