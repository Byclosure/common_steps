require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../common_steps_helper')
require "common_steps/helpers/record_helper"

# In order to use features without bugs
# As a developer
# I want to test my applications using record steps beginning with Given
describe "Cucumber instance with record_steps.rb and World(RecordHelper) loaded" do
  before do
    #record_steps.rb is loaded
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
  
  
  it "string 'Given the following artists' should match Step[Given the following (\w+)]" do
    @step_mother.step_match('the following artists')
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

  it "string 'Given there (is|are) (\w+) (\w+) with a (.*)' should match Step[Given the following (\w+)]" do
    @step_mother.step_match('the following artists')
  end
  
  
  
  it "calling 'Given the following artists' should be true" do
    
  end
  
end
