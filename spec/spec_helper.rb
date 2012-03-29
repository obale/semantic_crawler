require 'simplecov'
require 'simplecov-rcov'
SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
SimpleCov.start 'rails'

require 'rubygems'
require 'bundler/setup'

require 'semantic_crawler'

RSpec.configure do |config|
end

