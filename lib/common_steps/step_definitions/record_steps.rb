Given /^there (is|are) (\w+) (.*) with (a|an) (.*)$/ do |_, count_str, record_name, _, record_conditions|
  singular_record_name = record_singular_name(record_name)
  conditions = conditions_from_str(record_conditions)
  # record_name_to_class(record_name).delete_all
  num = str_to_num(count_str)
  num.times { Factory(singular_record_name.gsub(/\s/, "_"), conditions) }
end

Given /^there (is|are) (\w+) (\w+)$/ do |_, count_str, record_name|
  singular_record_name = record_singular_name(record_name)
  num = str_to_num(count_str)
  num.times { Factory(singular_record_name.gsub(/\s/, "_")) }
end

Given /^the following (.*):?$/ do |record_name, table|
  recordize!(record_name, table)
  singular_record_name = record_singular_name(record_name)
  table.hashes.each do |hash|
    Factory(singular_record_name.gsub(/\s/, "_"), hash)
  end
end

Then /^there should be (\d+) (.+)$/ do |count_str, record_name|
  num = str_to_num(count_str)
  record_name_to_class(record_name).should count(num)
end

Then /^there should be the following (.+):?$/ do |record_name, table|
  recordize!(record_name, table)
  record_class = record_name_to_class(record_name)
  table.hashes.each do |hash|
    record_class.exists?(hash).should == true # TODO vasco: make a matcher for this
  end
  @record_ops = {record_singular_name(record_name) => [table.hashes.map{|hash|record_class.find(:first, :conditions => hash, :select => [record_class.primary_key]).send(record_class.primary_key)}, table.hashes.first.keys]}
end

Then /^there should be (\w+) (\w+) with a (.*)$/ do |count_str, record_name, record_conditions|
  class_name = record_name_to_class(record_name)
  conditions = conditions_from_str(record_conditions)
  num = str_to_num(count_str)
  class_name.count(:conditions => conditions).should == num
end

Then /^I should see the following (\w+) in order$/ do |record_name, table|
  class_name = record_name_to_class(record_name)
  actual_table = table.headers.map {|h| Array(h)}
  #TODO
  class_name.find(:all).each do |record|
    actual_table << [record.name]
  end
  table.diff!(actual_table)
end