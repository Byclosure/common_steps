Dir[File.expand_path(File.dirname(__FILE__) + "/../matchers/*.rb")].each do |filename|
  require filename
end
