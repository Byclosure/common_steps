# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] ||= "test"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
require 'cucumber/rails/world'
require 'cucumber/rails/rspec'

require 'cucumber/formatter/unicode' # Comment out this line if you don't want Cucumber Unicode support

require 'rake'

require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

Before do
  DatabaseCleaner.start
  
#  ::Rake::Task["db:test:prepare"].execute
  ::Rake::Task["db:test:load_contents"].execute
end
 
After do
  DatabaseCleaner.clean
end

require "rumbster"
require "message_observers"

Before('@email') do
  @rumbster = Rumbster.new(ActionMailer::Base.smtp_settings[:port])
  @email_inbox = MailMessageObserver.new
  @rumbster.add_observer @email_inbox
  @rumbster.start
end

After('@email') do
  @rumbster.stop
end

def rake(task)
  `cd #{RAILS_ROOT} && RAILS_ENV=#{RAILS_ENV} rake #{task}`
end

require 'webrat'

Webrat.configure do |config|
  config.mode = ENV["MODE"] == "selenium" ? :selenium : :rails
end

require 'webrat/core/matchers'

require File.expand_path(File.dirname(__FILE__) + '../../../spec/spec_helper')

Dir["#{File.dirname(__FILE__)}/*_helper.rb"].each do |fn|
  require fn
  begin
    module_name = fn.chomp(".rb").classify.demodulize
    mod = module_name.constantize
    World(mod)
  rescue
    warn("unable to load: module `#{module_name}' in file #{fn}")
  end
end

