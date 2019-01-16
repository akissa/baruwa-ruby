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

ENV['CODECLIMATE_REPO_TOKEN'] = "69a832cbd11706e0578a20c2aae40d42cf520f3a9a776932bc32833dd1b58f2b"

WebMock.disable_net_connect!(:allow_localhost => true, :allow => "codeclimate.com")
