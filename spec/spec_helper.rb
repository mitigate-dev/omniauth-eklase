$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'omniauth-eklase'
require 'rack/test'
require 'webmock/rspec'
require 'byebug'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include WebMock::API
end
