require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../common_steps_helper')
require "common_steps/helpers/record_helper"

module StepMotherHelper
  def step_should_match(step_string)
    it { @step_mother.should step_match(step_string) }  
  end
  #  def step_should_not_match(step_string)
  #    it { @step_mother.should_not step_match(step_string) }  
  #  end
  
  
  def artist_should_count(n, opt_step_string=nil)
    is_or_are = n == 1 ? "is" : "are"
    plural_or_singular = n == 1 ? "" : "s" 
    step_string = opt_step_string || "there #{is_or_are} #{n} artist#{plural_or_singular}"
    it "should count #{n} Artist#{plural_or_singular} when I call '#{step_string}'" do
      m = @step_mother.step_match(step_string)
      m.invoke(nil)
      Artist.should count(n)
    end
  end
end

# In order to use features without bugs
# As a developer
# I want to test my applications using record steps beginning with Given
describe "Cucumber instance with record_steps.rb and World(RecordHelper) loaded" do
  extend StepMotherHelper
  
  before do
    @empty_table = Cucumber::Ast::Table.new([])
    @cucumber_table = Cucumber::Ast::Table.new(
      [['name', 'age'],
        ['John', '12'],
        ['Mary', '34']])
    @step_mother = Cucumber::Cli::Main.step_mother
    @step_mother.load_code_file(File.expand_path(File.dirname(__FILE__) + "/../../lib/common_steps/step_definitions/record_steps.rb"))
    @dsl = Object.new
    @dsl.extend(Cucumber::RbSupport::RbDsl)
    @dsl.World(RecordHelper)
    @step_mother.load_programming_language('rb').begin_rb_scenario
  end
  
  step_should_match 'the following artists'
  step_should_match 'there is a artist'
  step_should_match 'there is an artist'
  step_should_match 'there is 0 artists'
  step_should_match 'there is 1 artist'
  step_should_match 'there are 3 artists'
  
  describe "StepMatch[there (is|are) (\w+) (.*)] invokation, when there are no Artists" do
    before do
      Artist.destroy_all # there are no artist - FIXME I shouldn't have to care about this
    end
    
    artist_should_count 0
    artist_should_count 1
    artist_should_count 3
    
    artist_should_count 0, 'there are no artists'
    artist_should_count 1, 'there is an artist'
    artist_should_count 1, 'there is a artist'
  end
  
  
  describe "'Given the following artists' invoked with table of attributes" do
    it "should create the records" do
      m = @step_mother.step_match('the following artists')
      m.invoke(@cucumber_table)
      @cucumber_table.hashes.each do |hash|
        Artist.exists?(hash).should be_true
      end
    end
  end

end
