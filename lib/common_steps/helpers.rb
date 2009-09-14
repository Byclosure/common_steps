require "activesupport"

common_step_mods = []

Dir[File.dirname(__FILE__) + "/helpers/*.rb"].each do |filename|
  require filename
  module_name = filename.chomp(".rb").classify.demodulize
  mod = module_name.constantize rescue warn("unable to load: module `#{module_name}' in file #{filename}")
  common_step_mods << mod
end

Cucumber::RbSupport::RbDsl.build_rb_world_factory(common_step_mods, nil)

