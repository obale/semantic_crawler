require 'rubygems'
require 'bundler/setup'

require 'semantic_crawler'

require 'simplecov'
require 'simplecov-rcov'
SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
SimpleCov.start 'rails'

RSpec.configure do |config|
end

