require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")
require "common_steps/helpers/conditions_parser"

module ParserHelper
  def should_parse(input)
    it { @conditions_parser.should treetop_parse(input) }
  end
  
  def should_not_parse(input)
    it { @conditions_parser.should_not treetop_parse(input) }
  end
end

describe "ConditionsParser" do
  extend ParserHelper
  include TreetopParserMatchers
  
  before do
    @conditions_parser = ConditionsParser.new   # Dhaka::Parser.new(ConditionsGrammar)
    # @lexer = Dhaka::Lexer.new(ConditionsLexerSpecification)
  end
  
  # of separators
  should_parse "word of 'foo'"
  should_parse "word         of        'foo'"
  should_parse "two words of 'foo'"
  should_parse "of of 'foo'"
  should_parse "word of of 'foo'"
  should_parse "two of words of 'foo'"
  should_parse "of word of 'foo'"
  should_parse "of separator of 'foo'"
  should_not_parse "separatorof'foo'"
  should_not_parse "of 'foo'"
  should_parse "belonging to of 'boo'"
  should_parse "belonging    to    of 'boo'"
  should_parse "something belonging to of 'boo'"
  should_parse "something belonging to someone of 'boo'"
  should_parse "belonging to someone of 'boo'"
  should_parse "belonging to someone with of 'boo'"
  should_parse "belonging to someone with name of 'boo'"
  should_parse "belonging to someone with a of 'boo'"
  should_parse "belonging to someone with an of 'boo'"
  
  # => separator
  should_parse "separator => 'foo'"
  should_parse "separator      =>      'foo'"
  should_parse "separator=>'foo'"
  should_parse "word of => 'foo'"
  # should_parse "belonging to foo => ''"
  should_parse "belonging to => 'boo'"
  should_parse "belonging    to    => 'boo'"
  
  # values
  should_parse "string => 'foo'"
  should_parse 'string => "foo"'
  # should_parse "string => 'f\\'o\\'o'" future
  # should_parse 'string => "f\\"o\\"o"' future
  should_parse "integer => 23"
  should_parse "float => 23.000"
  should_parse "float => .5"
  should_parse "boolean => true"
  should_parse "boolean => false"
  should_parse "symbol => :foo"
  should_parse "null => nil"
  should_parse "two words => 'foo'"
  should_parse "two    words => 'foo'"
  should_parse "one_word => 'foo'"
  
  should_not_parse "bar => foo" # future meth (or #meth)
  should_not_parse "date => Date.today" # future
  
  should_parse "name of 'boo' and age of 23"
  should_parse "name of 'boo', age => 23, internal => true"
  should_parse "name => 'boo', age of 23, and internal of true"
  should_parse "name => 'boo', age of 23 and internal of true"
  should_parse "name => 'boo',           age => 23       ,      and      internal => true"

  should_parse "belonging to artist with a name of 'boo'"
  should_parse "belonging to magnific artist with a name of 'boo'"
  should_parse "belonging to artist with a name of 'boo', and age of 23"
  should_parse "belonging to artist with a name of 'boo'; and age of 50"
  should_parse "belonging to artist with with a name of 'boo'; and age of 50"
  should_parse "belonging to with artist with a name of 'boo'; and age of 50"
  should_parse "age of 50, belonging to artist with a name of 'foo'"
  should_not_parse "belonging to artist"
  should_not_parse "belonging to artist with a"
end