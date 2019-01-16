require 'simplecov'
SimpleCov.start
if ENV['CI']=='true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end
require 'rubygems'
require 'json'
require 'rspec'
require 'webmock/rspec'
require 'baruwa'

WebMock.disable_net_connect!(:allow_localhost => true)
