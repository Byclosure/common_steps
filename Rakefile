require 'rubygems'
require "rake/gempackagetask"
require "rake/clean"

Dir['tasks/**/*.rake'].each { |rake| load rake }
task :default => :spec

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "common_steps"
    gem.summary = %Q{common_steps. Some common cucumber step definitions, rake tasks, and rspec matchers}
    gem.description = gem.summary
    gem.email = ["vasco@byclosure.com", "duarte@byclosure.com"]
    gem.homepage = "http://github.com/Byclosure/common_steps"
    gem.authors = ["Vasco Andrade e Silva", "Duarte Henriques"]
    gem.add_development_dependency "rspec"
    gem.add_development_dependency "cucumber"
    gem.add_dependency 'activesupport'
    gem.add_dependency 'cucumber'
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end
