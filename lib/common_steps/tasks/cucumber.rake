desc "Run all features"
task :features => ['db:test:prepare', "features:all"]
require 'cucumber/rake/task' #I have to add this -mischa

namespace :features do
  Cucumber::Rake::Task.new(:all) do |t|  
    t.cucumber_opts = "-g --format pretty"
  end
  
  Cucumber::Rake::Task.new(:cruise) do |t|
    t.cucumber_opts = "-g --format pretty --out=#{ENV['CC_BUILD_ARTIFACTS']}/features.txt --format html --out=#{ENV['CC_BUILD_ARTIFACTS']}/features.html"
    t.rcov = true
    t.rcov_opts = %w{--rails --exclude osx\/objc,gems\/,spec\/}
    t.rcov_opts << %[-o "#{ENV['CC_BUILD_ARTIFACTS']}/features_rcov"]
  end
  
  Cucumber::Rake::Task.new(:rcov) do |t|    
    t.rcov = true
    t.rcov_opts = %w{--rails --exclude osx\/objc,gems\/,spec\/}
    t.rcov_opts << %[-o "features_rcov"]
  end
end
