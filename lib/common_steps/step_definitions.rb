Dir[File.dirname(__FILE__) + "/step_definitions/*.rb"].each do |filename|
  require filename
end
