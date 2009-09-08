When /^I (\w+) the form with$/ do |submit_name, table|
  pending
end

When /^I go to "([^\"]*)"$/ do |page_name|
  visit page_name
end

When /^I go to the homepage$/ do
  When 'I go to "/"'
end

Given /^I am on the new (\w+) page$/ do |record_name|
  When "I go to the new #{record_name} page"
end

When /^I go to the new (\w+) page$/ do |record_name|
  record_class = record_name_to_class(record_name)
  When "I go to \"/#{record_class_to_path(record_class)}/new\""
end

When /^I go to the list page of (\w+)$/ do |record_name|
  path = record_name.pluralize # TODO refact
  When "I go to \"/#{path}\""
end

Given /^I am on the edit page of the (\w+) with (a|an) (.*)$/ do |record_name, _, record_conditions|
  When "I go to the edit page of the #{record_name} with a #{record_conditions}"
end

When /^I go to the edit page of the (\w+) with (a|an) (.*)$/ do |record_name, _, record_conditions|
  record_class = record_name_to_class(record_name)
  record = find_record(record_class, record_conditions)
  When "I go to \"/#{record_class_to_path(record_class)}/#{record.id}/edit\""
end

When /^I go to the show page of the (\w+) with (a|an) (.*)$/ do |record_name, _, record_conditions|
  record_class = record_name_to_class(record_name)
  record = find_record(record_class, record_conditions)
  When "I go to \"/#{record_class_to_path(record_class)}/#{record.id}\""
end

#When /^I go to the delete page of (\w+) with (.*)$/ do |record_name|
#  pending
#end

Then /^I should be on "([^\"]*)"$/ do |page_name|
  URI.parse(current_url).path.should == page_name
end

Then /^I should be on the show page of the (\w+) with (a|an) (.*)$/ do |record_name, _,record_conditions|
  record_class = record_name_to_class(record_name)
  record = find_record(record_class, record_conditions)
  path = "/#{record_class_to_path(record_class)}/#{record.id}"
  URI.parse(current_url).path.should match(/#{path}/)
end

Then /^I should be on the edit page of the (\w+) with (a|an) (.*)$/ do |record_name, _,record_conditions|
  record_class = record_name_to_class(record_name)
  record = find_record(record_class, record_conditions)
  path = "/#{record_class_to_path(record_class)}/#{record.id}"
  URI.parse(current_url).path.should match(/#{path}/)
end

