require "activesupport"

Dir[File.dirname(__FILE__) + "/helpers/*.rb"].each do |filename|
  require filename
  module_name = filename.chomp(".rb").classify.demodulize
  mod = module_name.constantize rescue warn("unable to load: module `#{module_name}' in file #{filename}")
  World(mod) if defined?(World)
end

