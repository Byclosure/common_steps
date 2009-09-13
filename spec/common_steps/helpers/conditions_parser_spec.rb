require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")
require "common_steps/helpers/conditions_parser"

module ParserHelper
  module InputHelper
    def should_be_instance_of(klass)
      it { @input.should be_instance_of(klass) }
    end
    
    alias_method :instance_of, :should_be_instance_of
  end
  
  def should_parse(input, &block)
    it { @conditions_parser.should treetop_parse(input) }
    describe_input input, &block if block_given?
  end
  
  def should_not_parse(input)
    it { @conditions_parser.should_not treetop_parse(input) }
  end
  
  def describe_input(input, &block)
    describe "with input `#{input}'" do
      extend InputHelper
      before do
        @input = @conditions_parser.parse input
      end
      instance_eval(&block)
    end
  end
end

describe "ConditionsParser" do
  extend ParserHelper
  include TreetopParserMatchers
  
  before do
    @conditions_parser = ConditionsParser.new
  end
  
  # of separators
  should_parse "word of 'foo'" do
    instance_of(OfCondition)
  end
  should_parse "word         of        'foo'" do
    instance_of(OfCondition)
  end
  should_parse "two words of 'foo'" do
    instance_of(OfCondition)
  end
  should_parse "of of 'foo'" do
    instance_of(OfCondition)
  end
  should_parse "word of of 'foo'" do
    instance_of(OfCondition)
  end
  should_parse "two of words of 'foo'" do
    instance_of(OfCondition)
  end
  should_parse "of word of 'foo'" do
    instance_of(OfCondition)
  end
  should_parse "of separator of 'foo'" do
    instance_of(OfCondition)
  end
  should_parse "belonging to of 'boo'" do
    instance_of(OfCondition)
  end
  should_parse "belonging    to    of 'boo'"  do
    instance_of(OfCondition)
  end
  should_parse "something belonging to of 'boo'" do
    instance_of(OfCondition)
  end
  should_parse "something belonging to someone of 'boo'" do
    instance_of(OfCondition)
  end
  should_parse "belonging to someone of 'boo'" do
    instance_of(OfCondition)
  end
  should_parse "belonging to someone with of 'boo'" do
    instance_of(OfCondition)
  end
  should_parse "belonging to someone with name of 'boo'" do
    instance_of(OfCondition)
  end
  should_parse "belonging to someone with a of 'boo'" do
    instance_of(OfCondition)
  end
  should_parse "belonging to someone with an of 'boo'" do
    instance_of(OfCondition)
  end
  should_not_parse "separatorof'foo'"
  should_not_parse "of 'foo'"
  
  # => separator
  should_parse "word => 'foo'" do
    instance_of(ArrowCondition)
  end
  should_parse "word      =>      'foo'" do
    instance_of(ArrowCondition)
  end
  should_parse "word=>'foo'" do
    instance_of(ArrowCondition)
  end
  should_parse "word of => 'foo'" do
    instance_of(ArrowCondition)
  end
  # should_parse "belonging to foo => ''"
  should_parse "belonging to => 'boo'" do
    instance_of(ArrowCondition)
  end
  should_parse "belonging    to    => 'boo'" do
    instance_of(ArrowCondition)
  end
  should_parse "word of => 'foo'" do
    instance_of(ArrowCondition)
  end
  
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
=begin  
  it do
    p = @conditions_parser.parse("string => 'foo'")
    debugger
    nil
  end
=end
end