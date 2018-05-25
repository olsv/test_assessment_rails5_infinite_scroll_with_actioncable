require 'factory_bot'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  FactoryBot.lint strategy: :build
end
