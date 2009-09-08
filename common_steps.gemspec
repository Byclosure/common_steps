# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{common_steps}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [["Vasco Andrade e Silva", "Duarte Henriques"]]
  s.date = %q{2009-09-08}
  s.description = %q{common_steps. Some common cucumber step definitions, rake tasks, and rspec matchers}
  s.email = %q{vasco@byclosure.com}
  s.files = ["History.txt", "MIT-LICENSE.txt", "README.rdoc", "Rakefile", "lib/common_steps", "lib/common_steps/helpers", "lib/common_steps/helpers/record_helper.rb", "lib/common_steps/helpers.rb", "lib/common_steps/matchers", "lib/common_steps/matchers/count.rb", "lib/common_steps/step_definitions", "lib/common_steps/step_definitions/navigation_steps.rb", "lib/common_steps/step_definitions/record_steps.rb", "lib/common_steps/step_definitions/webrat_steps.rb", "lib/common_steps/step_definitions.rb", "lib/common_steps/support", "lib/common_steps/support/database.rb", "lib/common_steps/support/email.rb", "lib/common_steps/support/env.rb", "lib/common_steps/support/spec.rb", "lib/common_steps/tasks", "lib/common_steps/tasks/cucumber.rake", "lib/common_steps/tasks/rspec.rake", "lib/common_steps.rb"]
  s.homepage = %q{http://github.com/Byclosure/common_steps}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{common_steps. Some common cucumber step definitions, rake tasks, and rspec matchers}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
