# Sets up the Rails environment for Cucumber
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
require 'cucumber/rails/world'
require 'cucumber/rails/rspec'

require 'cucumber/formatter/unicode' # Comment out this line if you don't want Cucumber Unicode support

require 'rake'

def rake(task)
  `cd #{RAILS_ROOT} && RAILS_ENV=#{RAILS_ENV} rake #{task}`
end

require 'webrat'

Webrat.configure do |config|
  config.mode = ENV["MODE"] == "selenium" ? :selenium : :rails
end

require 'webrat/core/matchers'

require File.expand_path(File.dirname(__FILE__) + '../../../spec/spec_helper')


