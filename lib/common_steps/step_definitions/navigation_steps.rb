When /^I go to "([^\"]*)"$/ do |page_name|
  visit page_name
  @can_follow_url = page_name
  @can_take_screenshot = true
end

When /^I go to the homepage$/ do
  visit_homepage
end

Given /^I am on the new (.+) page$/ do |record_name|
  When "I go to the new #{record_name} page"
end

When /^I go to the new (.+) page$/ do |record_name|
  record_class = record_name_to_class(record_name)
  When "I go to \"#{record_class_to_path(record_class)}/new\""
end

When /^I go to the list page of (.+)$/ do |record_name|
  record_class = record_name_to_class(record_name)
  When "I go to \"#{record_class_to_path(record_class)}\""
end

Given /^I am on the edit page of the (.+) with (a|an) (.*)$/ do |record_name, _, record_conditions|
  When "I go to the edit page of the #{record_name} with a #{record_conditions}"
end

When /^I go to the edit page of the (.+) with (a|an) (.*)$/ do |record_name, _, record_conditions|
  record_class = record_name_to_class(record_name)
  record = find_record(record_class, record_conditions)
  When "I go to \"#{record_class_to_path(record_class)}/#{record.id}/edit\""
end

When /^I go to the show page of the (.+) with (a|an) (.*)$/ do |record_name, _, record_conditions|
  record_class = record_name_to_class(record_name)
  record = find_record(record_class, record_conditions)
  When "I go to \"#{record_class_to_path(record_class)}/#{record.id}\""
end

#When /^I go to the delete page of (\w+) with (.*)$/ do |record_name|
#  pending
#end

Then /^I should be on "([^\"]*)"$/ do |page_name|
  @can_follow_url = page_name
  @can_take_screenshot = true
  URI.parse(current_url).path.should == page_name
end

Then /^I should be on the show page of the (.+) with (a|an) (.*)$/ do |record_name, _,record_conditions|
  record_class = record_name_to_class(record_name)
  record = find_record(record_class, record_conditions)
  path = "#{record_class_to_path(record_class)}/#{record.id}"
  URI.parse(current_url).path.should match(/#{path}/)
end

Then /^I should be on the edit page of the (.+) with (a|an) (.*)$/ do |record_name, _,record_conditions|
  record_class = record_name_to_class(record_name)
  record = find_record(record_class, record_conditions)
  path = "#{record_class_to_path(record_class)}/#{record.id}"
  URI.parse(current_url).path.should match(/#{path}/)
end

Then /^I should be on the "(.+)" create page$/ do |record_name|
  record_class = record_name_to_class(record_name)
  path = "#{record_class_to_path(record_class)}/new"
  URI.parse(current_url).path.should match(/#{path}/)
end

Then /the field with label "([^\"]*)" should contain "([^\"]*)"/ do |field_name, content|
  field_labeled(field_name).value.should == content
end

# webrat steps

#When /^I press "([^\"]*)"$/ do |button|
#  click_button(button)
#end

#Then /^I should see "([^\"]*)"$/ do |text|
#  response.should contain(text)
#end
