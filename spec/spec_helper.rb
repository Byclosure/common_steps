$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'spec'
require 'spec/autorun'
require 'spec/mocks'

module DhakaParserMatchers
  class ParserMatcher
    def initialize(lexer, input_string)
      @lexer, @input_string = lexer, input_string
    end
    def matches?(parser)
      debugger
      @parser = parser
      result = @parser.parse(@lexer.lex(@input_string))
      !result.has_error?
    end
    def failure_message_for_should
      "expected #{@parser} to parse '#{@input_string}' using #{@lexer}"
    end
    def failure_message_for_should_not
      "expected #{@parser} not to parse '#{@input_string}' using #{@lexer}"
    end
    def description
      "parse '#{@input_string}'"
    end
  end
  
  def dhaka_parse(lexer, input_string)
    ParserMatcher.new(lexer, input_string)
  end
end

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