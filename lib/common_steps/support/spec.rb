require 'spec/autorun'
require 'spec/rails'
require 'spec/mocks'

Dir[File.expand_path(File.dirname(__FILE__) + "../matchers/*.rb")].each do |matcher_fn|
  require matcher_fn
end

# Spec::Runner.configure do |config|
# end

