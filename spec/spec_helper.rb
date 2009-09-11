$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'spec'
require 'spec/autorun'
require 'spec/mocks'

Spec::Runner.configure do |config|
end


Spec::Matchers.define :step_match do |expected_string|
  match do |step_mother|
    begin
      step_mother.step_match(expected_string)
    rescue Exception => @exception
      @exception
    end
    @exception.nil?
  end
  
  failure_message_for_should do |step_mother|
    "expected #{step_mother} to StepMatch[#{expected_string}], exception raised:\n" + 
      "Type: #{@exception.class}\n" +
      "Message: #{@exception.message}"
  end
  
  failure_message_for_should_not do |step_mother|
    # "expected #{collection} count not to be #{num}"
    "TODO"
  end

  description do
    "StepMatch[#{expected_string}]"
  end
end

#Copied from count.rb
Spec::Matchers.define :count do |num|
  match do |collection|
    collection.count == num
  end
  
  failure_message_for_should do |collection|
    "expected #{collection} count to be #{num} instead of #{collection.count}"
  end
  
  failure_message_for_should_not do |collection|
    "expected #{collection} count not to be #{num}"
  end

  description do
    "count should be #{num}"
  end
end

Spec::Matchers.define :exist_given do |hash|
  match do |@ar_class|
    @ar_class.exists?(hash)
  end
  
  failure_message_for_should do |ar_class|
    "expected an instance of #{ar_class} to exist, when #{ar_class}.exists?(#{hash.inspect})\n" +
      "Counting a total of: #{ar_class.count} #{ar_class}"
  end
  
  failure_message_for_should_not do |ar_class|
    "expected an instance of #{ar_class} _not_ to exist, when #{ar_class}.exists?(#{hash.inspect})\n" +
      "Counting a total of: #{ar_class.count} #{ar_class}"
  end

  description do
    "should exist at least one instance of #{@ar_class} with the attributes #{hash.inspect}"
  end
end
