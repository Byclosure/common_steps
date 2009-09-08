# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.dirname(__FILE__) + "/../config/environment" unless defined?(RAILS_ROOT)
require 'spec/autorun'
require 'spec/rails'
require 'spec/mocks'


Spec::Runner.configure do |config|
  # == Mock Framework
  #
  # RSpec uses it's own mocking framework by default. If you prefer to
  # use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  #
  # == Notes
  # 
  # For more information take a look at Spec::Runner::Configuration and Spec::Runner
end

Spec::Matchers.define :count do |num|
  match do |collection|
    collection.count == num
  end
  
  failure_message_for_should do |collection|
    "expected #{collection} count to be #{num} instead of #{collection.count}"
  end
  
  failure_message_for_should_not do |collection|
    "expected #{collection} count not to be #{num}"
  end

  description do
    "count should be #{num}"
  end
end