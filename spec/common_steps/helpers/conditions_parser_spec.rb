require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")
require "common_steps/helpers/conditions_parser"

module ParserHelper
  module InputHelper
    def should_be_instance_of(klass)
      it { @parse_tree.should be_instance_of(klass) }
    end
    
    def should_be_a(klass)
      it { @parse_tree.should be_a(klass) }
    end
    
    alias_method :instance_of, :should_be_instance_of
    alias_method :be_a, :should_be_a
    
    def conditions_should_be(*conditions)
      it "conditions should be of type: #{conditions.inspect}" do
        @parse_tree.splited_conditions.map(&:class).should == conditions
      end
    end
    
    def conditions_hash_should_be(hash)
      it "conditions hash should be #{hash.inspect}" do
        @parse_tree.conditions_hash.should == hash
      end
    end
    
    alias_method :conditions_hash, :conditions_hash_should_be
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
        @parse_tree = @conditions_parser.parse input
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
    conditions_hash 'word' => 'foo'
  end
  should_parse "word         of        'foo'" do
    instance_of(OfCondition)
    conditions_hash 'word' => 'foo'
  end
  should_parse "two words of 'foo'" do
    instance_of(OfCondition)
    conditions_hash 'two words' => 'foo'
  end
  should_parse "of of 'foo'" do
    instance_of(OfCondition)
    conditions_hash 'of' => 'foo'
  end
  should_parse "word of of 'foo'" do
    instance_of(OfCondition)
    conditions_hash 'word of' => 'foo'
  end
  should_parse "two of words of 'foo'" do
    instance_of(OfCondition)
    conditions_hash 'two of words' => 'foo'
  end
  should_parse "of word of 'foo'" do
    instance_of(OfCondition)
    conditions_hash 'of word' => 'foo'
  end
  should_parse "of word of 'foo'" do
    instance_of(OfCondition)
    conditions_hash 'of word' => 'foo'
  end
  should_parse "belonging to of 'boo'" do
    instance_of(OfCondition)
    conditions_hash 'belonging to' => 'boo'
  end
  should_parse "belonging    to    of 'boo'"  do
    instance_of(OfCondition)
    conditions_hash 'belonging to' => 'boo'
  end
  should_parse "something belonging to of 'boo'" do
    instance_of(OfCondition)
    conditions_hash 'something belonging to' => 'boo'
  end
  should_parse "something belonging to someone of 'boo'" do
    instance_of(OfCondition)
    conditions_hash 'something belonging to someone' => 'boo'
  end
  should_parse "belonging to someone of 'boo'" do
    instance_of(OfCondition)
    conditions_hash 'belonging to someone' => 'boo'
  end
  should_parse "belonging to someone with of 'boo'" do
    instance_of(OfCondition)
    conditions_hash 'belonging to somenone with' => 'boo'
  end
  should_parse "belonging to someone with name of 'boo'" do
    instance_of(OfCondition)
    conditions_hash 'belonging to someone with name' => 'boo'
  end
  should_parse "belonging to someone with a of 'boo'" do
    instance_of(OfCondition)
    conditions_hash 'belonging to someone with a' => 'boo'
  end
  should_parse "belonging to someone with an of 'boo'" do
    instance_of(OfCondition)
    conditions_hash 'belonging to someone with an' => 'boo'
  end
  should_not_parse "separatorof'foo'"
  should_not_parse "of 'foo'"
  
  # => separator
  should_parse "word => 'foo'" do
    instance_of(ArrowCondition)
    conditions_hash 'word' => 'foo'
  end
  should_parse "word      =>      'foo'" do
    instance_of(ArrowCondition)
    conditions_hash 'word' => 'foo'
  end
  should_parse "word=>'foo'" do
    instance_of(ArrowCondition)
    conditions_hash 'word' => 'foo'
  end
  should_parse "word of => 'foo'" do
    instance_of(ArrowCondition)
    conditions_hash "word of" => 'foo'
  end
  # should_parse "belonging to foo => ''"
  should_parse "belonging to => 'boo'" do
    instance_of(ArrowCondition)
    conditions_hash "belonging to" => 'boo'
  end
  should_parse "belonging    to    => 'boo'" do
    instance_of(ArrowCondition)
    conditions_hash "belonging to" => 'boo'
  end
  should_parse "word of => 'foo'" do
    instance_of(ArrowCondition)
    conditions_hash 'word of' => 'foo'
  end
  
  # values
  should_parse "string => 'foo'" do
    instance_of(ArrowCondition)
    conditions_hash 'string' => 'foo'
  end
  should_parse 'string => "foo"' do
    instance_of(ArrowCondition)
    conditions_hash 'string' => 'foo'
  end
  # should_parse "string => 'f\\'o\\'o'" future
  # should_parse 'string => "f\\"o\\"o"' future
  should_parse "integer => 23" do
    instance_of(ArrowCondition)
    conditions_hash 'integer' => 23
  end
  should_parse "float => 23.000" do
    instance_of(ArrowCondition)
    conditions_hash 'float' => 23.0
  end
  should_parse "float => .5" do
    instance_of(ArrowCondition)
    conditions_hash 'float' => 0.5
  end
  should_parse "boolean => true" do
    instance_of(ArrowCondition)
    conditions_hash 'boolean' => true
  end
  should_parse "boolean => false" do
    instance_of(ArrowCondition)
    conditions_hash 'boolean' => false
  end
  should_parse "symbol => :foo" do
    instance_of(ArrowCondition)
    conditions_hash 'symbol' => :foo
  end
  should_parse "null => nil" do
    instance_of(ArrowCondition)
    conditions_hash "null" => nil
  end
  should_parse "two words => 'foo'" do
    instance_of(ArrowCondition)
    conditions_hash 'two words' => 'foo'
  end
  should_parse "two    words => 'foo'" do
    instance_of(ArrowCondition)
    conditions_hash 'two words' => 'foo'
  end
  should_parse "one_word => 'foo'" do
    instance_of(ArrowCondition)
    conditions_hash 'one_word' => 'foo'
  end
  
  should_not_parse "bar => foo" # future meth (or #meth)
  should_not_parse "date => Date.today" # future


  should_parse "name of 'boo' and age of 23" do
    be_a(SplitConditions)
    conditions_should_be OfCondition, OfCondition
    conditions_hash 'name' => 'boo', 'age' => 23
  end
  should_parse "name of 'boo', age => 23, internal => true" do
    be_a(SplitConditions)
    conditions_should_be OfCondition, ArrowCondition, ArrowCondition
    conditions_hash 'name' => 'boo', 'age' => 23, 'internal' => true
  end  
  should_parse "name => 'boo', age of 23, and internal of true" do
    be_a(SplitConditions)
    conditions_should_be ArrowCondition, OfCondition, OfCondition
    conditions_hash 'name' => 'boo', 'age' => 23, 'internal' => true
  end
  should_parse "name => 'boo', age of 23 and internal of true" do
    be_a(SplitConditions)
    conditions_should_be ArrowCondition, OfCondition, OfCondition
    conditions_hash 'name' => 'boo', 'age' => 23, 'internal' => true
  end
  should_parse "name => 'boo',           age => 23.0       ,      and      internal => true" do
    be_a(SplitConditions)
    conditions_should_be ArrowCondition, ArrowCondition, ArrowCondition
    conditions_hash 'name' => 'boo', 'age' => 23.0, 'internal' => true
  end
  
  should_parse "belonging to artist with a name of 'boo'" do
    instance_of(BelongingToCondition)
    conditions_hash 'artist' => {'name' => 'boo'}
  end
=begin  
  should_parse "belonging to magnific artist with a name of 'boo'" do
    instance_of(BelongingToCondition)
    conditions_hash 'magnific artist' => {'name' => 'boo'}
  end
  should_parse "belonging to artist with a name of 'boo', and age of 23" do
    instance_of(BelongingToCondition)
    conditions_hash 'artist' => {'name' => 'boo', 'age' => 23}
  end
  should_parse "belonging to artist with a name of 'boo'; and age of 50" do
    be_a(SplitConditions)
    conditions_should_be BelongingToCondition, OfCondition
    conditions_hash 'artist' => {'name' => 'boo', 'age' => 50}
  end
  should_parse "belonging to artist with with a name of 'boo'; and age of 50" do
    be_a(SplitConditions)
    conditions_should_be BelongingToCondition, OfCondition
    conditions_hash 'artist' => {'name' => 'boo'}, 'age' => 50
  end
  should_parse "belonging to with artist with a name of 'boo'; and age of 50" do
    be_a(SplitConditions)
    conditions_should_be BelongingToCondition, OfCondition
    conditions_hash 'with artist' => {'name' => 'boo'}, 'age' => 50
  end
  should_parse "age of 50, belonging to artist with a name of 'foo'" do
    be_a(SplitConditions)
    conditions_should_be OfCondition, BelongingToCondition, OfCondition
    conditions_hash 'age' => 50, 'artist' => {'name' => 'foo'}
  end
  should_not_parse "belonging to artist"
  should_not_parse "belonging to artist with a"
=end
=begin  
  it do
    p = @conditions_parser.parse("string => 'foo'")
    debugger
    nil
  end
=end
end