Given /^there (is|are) (\w+) (\w+) with a (.*)$/ do |_, count_str, record_name, record_conditions|
  factory_name = record_singular_name(record_name)
  conditions = conditions_from_str(record_name_to_class(record_name), record_conditions)
  num = str_to_num(count_str)
  num.times { Factory(factory_name, conditions) }
end

Given /^there (is|are) (\w+) (\w*)$/ do |_, count_str, record_name|
  factory_name = record_singular_name(record_name)
  num = str_to_num(count_str)
  num.times { Factory(factory_name) }
end

Then /^there should be (\w+) (\w+)$/ do |count_str, record_name|
  num = str_to_num(count_str)
  record_name_to_class(record_name).should count(num)
end

Given /^the following (\w+):?$/ do |record_name, table|
  record_table = recordize!(table)
  factory_name = record_singular_name(record_name)
  record_table.hashes.each do |hash|
    Factory(factory_name, hash)
  end
end

=begin
class_name = model_name.gsub(' ', '_').singularize
model_class = nil
begin
  model_class = class_name.classify.constantize
rescue
  # do nothing
end
model_class.delete_all if model_class
table.hashes.each do |hash|
  attr_hash = hash.inject({}) do |attr_hash, (attr_name, attr_value)|
    if attr_name == 'user' && !attr_value.is_a?(User) # hack
      attr_hash[attr_name] = find_or_create_valid_user(:login => attr_value)
    elsif attr_name == "published_at" && hash['published_as'] == "draft" # hack
      attr_hash[attr_name] = nil
    elsif (model_class && (association = model_class.reflect_on_all_associations(:has_many).detect { |a| attr_name =~ /^(#{a.name})(_.*)/ }))
      find_suffix = $2
      attr_hash[association.name] = if attr_value.nil?
        []
      else
        association_class = association.class_name.constantize
        attr_value.split(", ").map do |v|
          association_class.send("find_by#{find_suffix}", v)
        end
      end
    else
      attr_hash[attr_name] = attr_value
    end
    attr_hash
  end
 
  approve = attr_hash.delete("approve")
  model = Factory(class_name.to_sym, attr_hash)
  if approve == "true"
    model.approve!
  end
  model
end
=end

=begin
Given /^the following (.+) records?$/ do |model_name, table|
  class_name = model_name.gsub(' ', '_').singularize
  model_class = class_name.classify.constantize
  model_class.delete_all
  has_many_opts = model_class.reflect_on_all_associations(:has_many)
  table.hashes.each do |hash|
    attr_hash = hash.inject({}) do |attr_hash, (attr_name, attr_value)|
      if attr_name == 'user' && !attr_value.is_a?(User) # hack
        attr_hash[attr_name] = find_or_create_valid_user(:login => attr_value)
      elsif attr_name == "published_at" && hash['published_as'] == "draft" # hack
        attr_hash[attr_name] = nil
      elsif (association = has_many_opts.detect { |a| attr_name =~ /^(#{a.name})(_.*)/ })
        find_suffix = $2
        attr_hash[association.name] = if attr_value.nil?
          []
        else
          association_class = association.class_name.constantize
          attr_value.split(", ").map do |v|
            association_class.send("find_by#{find_suffix}", v)
          end
        end
      else
        attr_hash[attr_name] = attr_value
      end
      attr_hash
    end
   
    approve = attr_hash.delete("approve")
    model = Factory(class_name.to_sym, attr_hash)
    if approve == "true"
      model.approve!
    end
    model
  end
end


Given /^there is a ([^\" ]+)$/ do |resource|
  instance_variable_set(:"@#{resource.gsub(' ', '_')}", respond_to?(:"create_valid_#{resource.gsub(' ', '_')}") ? send(:"create_valid_#{resource.gsub(' ', '_')}") : Factory(:"#{resource.gsub(' ', '_')}"))
end
Given /^there is a (.+) with (.+) "([^\"]*)"$/ do |resource, field, value|
  resource_name = resource.gsub(' ', '_')
  resource_name.classify.constantize.find(:all, :conditions => {field => value}).map(&:destroy) rescue nil # in case there is a uniqueness validation
  method = :"create_valid_#{resource_name}"
  instance_variable_set(:"@#{resource_name}", respond_to?(method) ? send(method, field.to_sym => value) : Factory(resource_name, field.to_sym => value))
end
Given /^there is an (.+) with (.+) "([^\"]*)"$/ do |resource, field, value|
  resource_name = resource.gsub(' ', '_')
  resource_name.classify.constantize.find(:all, :conditions => {field => value}).map(&:destroy) rescue nil # in case there is a uniqueness validation
  method = :"create_valid_#{resource_name}"
  instance_variable_set(:"@#{resource_name}", respond_to?(method) ? send(method, field.to_sym => value) : Factory(resource_name, field.to_sym => value))
end
#Given /^I have only one (.+)$/ do |resource|
#  @myself.send(resource.pluralize).delete_all
#  instance_variable_set(:"@#{resource.gsub(' ', '_')}", send(:"create_valid_#{resource.gsub(' ', '_')}"))
#end
Given /^I have only one (.+) with (.+) "([^\"]*)"$/ do |resource, field, value|
  @myself.send(resource.pluralize).delete_all
  resource.classify.constantize.find(:all, :conditions => {field => value}).map(&:destroy) rescue nil # in case there is a uniqueness validation
  instance_variable_set(:"@#{resource.gsub(' ', '_')}", send(:"create_valid_#{resource.gsub(' ', '_')}", field.to_sym => value, :user => @myself))
end
Given /^I have a (.+) with (.+) "([^\"]*)"$/ do |resource, field, value|
  resource.classify.constantize.find(:all, :conditions => {field => value}).map(&:destroy) rescue nil # in case there is a uniqueness validation
  instance_variable_set(:"@#{resource.gsub(' ', '_')}", send(:"create_valid_#{resource.gsub(' ', '_')}", field.to_sym => value, :user => @myself))
end

Then /^there should be ([0-9]+) (.+)$/ do |count, resource|
  resource.singularize.classify.constantize.count.should == count.to_i
end

Then /^I should have ([0-9]+) (.+)$/ do |count, resource|
  @myself.send(resource.pluralize).count.should == count.to_i
end

Given /^there are no ([^ ]+)$/ do |resource|
  resource.singularize.classify.constantize.delete_all
end

Then /^that (.+) should be deleted$/ do |resource|
  lambda { instance_variable_get(:"@#{resource}").reload }.should raise_error ActiveRecord::RecordNotFound
end
Then /^that (.+) should no longer exist$/ do |resource|
  lambda { instance_variable_get(:"@#{resource}").reload }.should raise_error ActiveRecord::RecordNotFound
end
=end