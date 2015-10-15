require 'simplecov'
SimpleCov.start
require 'rubygems'
require 'json'
require 'rspec'
require 'webmock/rspec'
require 'baruwa'

WebMock.disable_net_connect!(:allow_localhost => true)
