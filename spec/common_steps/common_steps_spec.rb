require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../common_steps_helper')
require "common_steps/helpers/record_helper"

module StepMotherHelper
  def step_should_match(step_string)
    it { @step_mother.should step_match(step_string) }  
  end  
  
  def artist_should_count(n, step_string)
    plural_or_singular = n == 1 ? "" : "s" 
    it "should count #{n} Artist#{plural_or_singular} when I call '#{step_string}'" do
      m = @step_mother.step_match(step_string)
      m.invoke(nil)
      Artist.should count(n)
    end
  end  
  
  def artist_should_be(hash, step_string)
    it "should contain #{hash.inspect} when I call '#{step_string}'" do
      m = @step_mother.step_match(step_string)
      m.invoke(nil)
      Artist.should exist_given(hash)
    end
  end
  
  def artist_should_count_and_be(n, hash, step_string)
    artist_should_count(n, step_string)
    artist_should_be(hash, step_string)
  end
  
  def artists_in_table_should_be(table, step_string)    
    it "should contain the table #{table.hashes.inspect} when I call '#{step_string}" do  
      m = @step_mother.step_match('the following artists')
      m.invoke(table)
      table.hashes.each do |hash|
        Artist.should exist_given(hash)
      end
    end
  end
end

# In order to use features without bugs
# As a developer
# I want to test my applications using record steps beginning with Given
describe "Cucumber instance with record_steps.rb and World(RecordHelper) loaded" do
  extend StepMotherHelper
  
  before do
    @step_mother = Cucumber::Cli::Main.step_mother
    @step_mother.load_code_file(File.expand_path(File.dirname(__FILE__) + "/../../lib/common_steps/step_definitions/record_steps.rb"))
    @dsl = Object.new
    @dsl.extend(Cucumber::RbSupport::RbDsl)
    @dsl.World(RecordHelper)
    @step_mother.load_programming_language('rb').begin_rb_scenario
  end
  
  # Specs from record_steps.rb
  #
  # there (is|are) (\w+) (\w*)
  step_should_match 'there are no artists'
  step_should_match 'there is no artists'
  step_should_match 'there are no artist'
  step_should_match 'there is 0 artists'
  step_should_match 'there is a artist'
  step_should_match 'there is an artist'
  step_should_match 'there is 1 artist'
  step_should_match 'there are 3 artists'

  # there (is|are) (\w+) (\w+) with a (.*)
  step_should_match 'there are 0 artists with a name of "John"'
  step_should_match 'there are no artists with a name of "John"'
  step_should_match 'there is 1 artist with a name of "John"'
  step_should_match 'there is an artist with a name of "John"'
  step_should_match 'there is a artist with a name of "John"'
  step_should_match 'there are 3 artists with a name of "John"'
  step_should_match 'there are 1 artists with a name of "John", an age of 32 and a country of "Portugal"'
      
  # there should be (\w+) (\w+)
  step_should_match 'there should be no artists'
  step_should_match 'there should be no artists'
  step_should_match 'there should be no artist'
  step_should_match 'there should be 0 artists'
  step_should_match 'there should be a artist'
  step_should_match 'there should be an artist'
  step_should_match 'there should be 1 artist'
  step_should_match 'there should be 3 artists'

  #the following (\w+):
  step_should_match 'the following artists'
  step_should_match 'the following artists:'
  step_should_match 'the following artist'
  step_should_match 'the following artist:'
  
  # there should be (\w+) (\w+) with a (.*)
  step_should_match 'there should be 0 artists with a name of "John"'
  step_should_match 'there should be no artists with a name of "John"'
  step_should_match 'there should be 1 artist with a name of "John"'
  step_should_match 'there should be an artist with a name of "John"'
  step_should_match 'there should be a artist with a name of "John"'
  step_should_match 'there should be 3 artists with a name of "John"'
  step_should_match 'there should be 1 artist with a name of "John", an age of 32 and a country of "Portugal"'
  
  # there should be the following (\w+):?
  step_should_match 'there should be the following artists'
  step_should_match 'there should be the following artists:'
  step_should_match 'there should be the following artist'
  step_should_match 'there should be the following artist:'
  
  # I should see the following (\w+) in order
  step_should_match 'I should see the following artists in order'
  step_should_match 'I should see the following artist in order'
  
  describe "StepMatch[there (is|are) (\w+) (\w+) with a (.*)] invocation, with no artists" do
    before do
      Artist.destroy_all # there are no artist - FIXME I shouldn't have to care about this
    end
    
    artist_should_count(0, 'there are 0 artists with a name of "John"')
    artist_should_count(0, 'there are no artists with a name of "John"')
    
    artist_should_count_and_be(1, {:name => "John"}, 'there is 1 artist with a name of "John"')
    artist_should_count_and_be(1, {:name => "John"}, 'there is an artist with a name of "John"')
    artist_should_count_and_be(1, {:name => "John"}, 'there is a artist with a name of "John"')
    artist_should_count_and_be(3, {:name => "John"}, 'there are 3 artists with a name of "John"')
    artist_should_count_and_be(1, {:name => "John", :age => 32}, 'there are 1 artists with a name of "John", and age of 32')
    
    # To discuss later
    #artist_should_count_and_be(1, {:name => "John", :age => 32}, 'there are 1 artists with a name of "John", and age of 32')
  end
  
  describe "StepMatch[there (is|are) (\w+) (.*)] invocation, with no artists" do
    before do
      Artist.destroy_all # there are no artist - FIXME I shouldn't have to care about this
    end
    
    artist_should_count 0, 'there are 0 artists'
    artist_should_count 0, 'there are no artists'
    artist_should_count 1, 'there is 1 artist'
    artist_should_count 1, 'there is an artist'
    artist_should_count 1, 'there is a artist'
    artist_should_count 3, 'there are 3 artists'
  end
  
  describe "StepMatch[there should be (\w+) (\w+)] invocation with 1 artist, with no artists" do
    before do
      Artist.destroy_all # there are no artist - FIXME I shouldn't have to care about this
    end
    
    artist_should_count 0, 'there should be 0 artists'
    artist_should_count 0, 'there should be no artists'
  end
  
  describe "StepMatch[there should be (\w+) (\w+)] invocation with 1 artist, with 1 artist" do
    before do
      Artist.destroy_all # there are no artist - FIXME I shouldn't have to care about this
      Factory(:artist)
    end

    artist_should_count 1, 'there should be 1 artist'
    artist_should_count 1, 'there should be an artist'
    artist_should_count 1, 'there should be a artist'   
  end
   
  describe "StepMatch[Given the following artists] invoked with table of attributes" do
    before do
      Artist.destroy_all # there are no artist - FIXME I shouldn't have to care about this
    end
    
    @cucumber_table = Cucumber::Ast::Table.new(
      [['name', 'age'],
        ['John', '12'],
        ['Mary', '34']])
    artists_in_table_should_be @cucumber_table, 'the following artists'
  end

  describe "StepMatch[there should be (\w+) (\w+) with a (.*)] with no artists" do
    before do
      Artist.destroy_all # there are no artist - FIXME I shouldn't have to care about this
    end
    
    artist_should_count(0, 'there should be 0 artists with a name of "John"')
    artist_should_count(0, 'there should be no artists with a name of "John"')
  end
  
  describe "StepMatch[there should be (\w+) (\w+) with a (.*)] with 1 artist" do
    before do
      Artist.destroy_all # there are no artist - FIXME I shouldn't have to care about this
      Artist.create!(:name => "John", :age => 32)
    end

    it "should not raise error when I invoke StepMatch[there should be 1 artist with a name of 'John'] with [{:name => 'John', :age => 12}, {:name => 'Mary', :age => 34}]" do
      lambda do
        m = @step_mother.step_match('there should be 1 artist with a name of "John"')
        m.invoke(nil)
      end.should_not raise_error 
    end
    
    it "should not raise error when I invoke StepMatch['there should be 1 artist with a name of \"John\"'] with [{:name => 'John', :age => 12}, {:name => 'Mary', :age => 34}]" do
      lambda do
        m = @step_mother.step_match('there should be an artist with a name of "John"')
        m.invoke(nil)
      end.should_not raise_error 
    end

    it "should not raise error when I invoke StepMatch[''there should be a artist with a name of \"John\"''] with [{:name => 'John', :age => 12}, {:name => 'Mary', :age => 34}]" do
      lambda do
        m = @step_mother.step_match('there should be a artist with a name of "John"')
        m.invoke(nil)
      end.should_not raise_error 
    end
    
    it "should not raise error when I invoke StepMatch['there should be 1 artists with a name of \"John\", and age of 32'] with [{:name => 'John', :age => 12}, {:name => 'Mary', :age => 34}]" do
      lambda do
        m = @step_mother.step_match('there should be 1 artists with a name of "John", and age of 32')
        m.invoke(nil)
      end.should_not raise_error 
    end
  end
    
  describe "where there are 2 artists [{:name => 'John', :age => 12}, {:name => 'Mary', :age => 34}]" do
    before do
      Artist.destroy_all # there are no artist - FIXME I shouldn't have to care about this
      Artist.create!(:name => "John", :age => 12)
      Artist.create!(:name => "Mary", :age => 34)
    end
    
    it "should not raise error when I invoke StepMatch[there should be the following (\w+):?] with [{:name => 'John', :age => 12}, {:name => 'Mary', :age => 34}]" do
      lambda do
        m = @step_mother.step_match("there should be the following artists")
        m.invoke(Cucumber::Ast::Table.new(
            [['name', 'age'],
              ['John', '12'],
              ['Mary', '34']]))
      end.should_not raise_error 
    end
    
    it "should raise error when I invoke StepMatch[there should be the following (\w+):?] with [{:name => 'Ann', :age => 12}]" do
      lambda do
        m = @step_mother.step_match("there should be the following artists")
        m.invoke(Cucumber::Ast::Table.new(
            [['name', 'age'],
              ['Ann', '12']]))
      end.should raise_error
    end

    it "should raise error when I invoke StepMatch[there should be the following (\w+):?] with [{:name => 'John', :age => 12}, {:name => 'Mary', :age => 34}, {:name => 'Andrea', :age => 22}]" do
      lambda do
        m = @step_mother.step_match("there should be the following artists")
        m.invoke(Cucumber::Ast::Table.new(
            [['name', 'age'],
              ['John', '12'],
              ['Mary', '34'],
              ['Andrea', '22']]))
      end.should raise_error      
    end
    

  end

  
end
