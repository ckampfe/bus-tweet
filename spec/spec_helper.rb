require File.expand_path('../config/environment', File.dirname(__FILE__))
require 'factory_girl'
require 'factories'
require 'database_cleaner'

Dir[APP_ROOT.join('app', 'models', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }

#specs
Dir['bus-tweet/*.rb'].each { |file| require file }

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    begin
      DatabaseCleaner.start
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end
end
