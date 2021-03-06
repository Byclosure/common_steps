# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{common_steps}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Vasco Andrade e Silva", "Duarte Henriques"]
  s.date = %q{2009-11-10}
  s.description = %q{common_steps. Some common cucumber step definitions, rake tasks, and rspec matchers}
  s.email = ["vasco@byclosure.com", "duarte@byclosure.com"]
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "MIT-LICENSE.txt",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "common_steps.gemspec",
     "features/common_steps.feature",
     "features/step_definitions/common_steps_steps.rb",
     "features/support/env.rb",
     "lib/common_steps.rb",
     "lib/common_steps/helpers.rb",
     "lib/common_steps/helpers/conditions.treetop",
     "lib/common_steps/helpers/conditions_parser.rb",
     "lib/common_steps/helpers/navigation_helper.rb",
     "lib/common_steps/helpers/rake_helper.rb",
     "lib/common_steps/helpers/record_helper.rb",
     "lib/common_steps/matchers/count.rb",
     "lib/common_steps/step_definitions.rb",
     "lib/common_steps/step_definitions/navigation_steps.rb",
     "lib/common_steps/step_definitions/record_steps.rb",
     "lib/common_steps/step_definitions/webrat_steps.rb",
     "lib/common_steps/support/database.rb",
     "lib/common_steps/support/email.rb",
     "lib/common_steps/support/spec.rb",
     "lib/common_steps/tasks/cucumber.rake",
     "lib/common_steps/tasks/rspec.rake",
     "spec/common_steps/helpers/conditions_parser_spec.rb",
     "spec/common_steps/helpers/record_helper_spec.rb",
     "spec/common_steps/helpers/step_mother_helper.rb",
     "spec/common_steps/navigation_steps_spec.rb",
     "spec/common_steps/record_steps_spec.rb",
     "spec/common_steps_helper.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb",
     "tasks/cucumber.rake",
     "tasks/rdoc.rake",
     "tasks/roodi.rake",
     "tasks/rspec.rake"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/Byclosure/common_steps}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{common_steps. Some common cucumber step definitions, rake tasks, and rspec matchers}
  s.test_files = [
    "spec/common_steps/helpers/conditions_parser_spec.rb",
     "spec/common_steps/helpers/record_helper_spec.rb",
     "spec/common_steps/helpers/step_mother_helper.rb",
     "spec/common_steps/navigation_steps_spec.rb",
     "spec/common_steps/record_steps_spec.rb",
     "spec/common_steps_helper.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<cucumber>, [">= 0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
      s.add_runtime_dependency(%q<cucumber>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<cucumber>, [">= 0"])
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<cucumber>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<cucumber>, [">= 0"])
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<cucumber>, [">= 0"])
  end
end
