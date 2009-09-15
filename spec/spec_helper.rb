$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'spec'
require 'spec/autorun'
require 'spec/mocks'

module TreetopParserMatchers
  class ParserMatcher
    def initialize(input_string)
      @input_string = input_string
    end
    def matches?(parser)
      @parser = parser
      !@parser.parse(@input_string).nil?
    end
    def failure_message_for_should
      "expected #{@parser} to parse '#{@input_string}'\n" + 
      "failure column: #{@parser.failure_column}\n" +
      "failure index: #{@parser.failure_index}\n" +
      "failure line: #{@parser.failure_line}\n" +
      # "terminal failures: #{@parser.terminal_failures}\n" +  PROBLEMS: raising exception on treetop side
      "failure reason: #{@parser.failure_reason}\n"
    end
    def failure_message_for_should_not
      "expected #{@parser} not to parse '#{@input_string}'"
    end
    def description
      "parse `#{@input_string}'"
    end
  end
  
  def treetop_parse(input_string)
    ParserMatcher.new(input_string)
  end
end



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
