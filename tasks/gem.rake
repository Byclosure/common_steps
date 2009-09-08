spec = Gem::Specification.new do |s|
  s.name         = "common_steps"
  s.version      = "0.1.0" # CommonSteps::VERSION::STRING
  s.authors       = ["Vasco Andrade e Silva", "Duarte Henriques"]
  s.email        = "vasco@byclosure.com"
  s.homepage     = "http://github.com/Byclosure/common_steps"
  s.summary      = "common_steps. Some common cucumber step definitions, rake tasks, and rspec matchers"
  s.description  = s.summary
  s.files        = %w[MIT-LICENSE.txt README.rdoc Rakefile] + Dir["lib/**/*"]# + Dir["vendor/**/*"]
  
  #s.add_dependency ""
end

Rake::GemPackageTask.new(spec) do |package|
  package.gem_spec = spec
end

desc 'Show information about the gem.'
task :gemspec do
  File.open("common_steps.gemspec", 'w') do |f|
    f.write spec.to_ruby
  end
  puts "Generated: common_steps.gemspec"
end

CLEAN.include ["pkg", "*.gem", "doc", "ri", "coverage"]

desc 'Install the package as a gem.'
task :install => [:clean, :package] do
  gem = Dir['pkg/*.gem'].first
  sh "sudo gem install --no-ri --no-rdoc --local #{gem}"
end

