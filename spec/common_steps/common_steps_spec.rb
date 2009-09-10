require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../common_steps_helper')
require File.expand_path(File.dirname(__FILE__) + '/../common_steps_helper')
require "common_steps/helpers/record_helper"

# In order to use features without bugs
# As a developer
# I want to test my applications using record steps beginning with Given
describe "Cucumber instance with record_steps.rb and World(RecordHelper) loaded" do
  before do
    #record_steps.rb is loaded
    @cucumber_table = Cucumber::Ast::Table.new(
      [['attr_1', 'attr_2', 'attr_3', 'attr_4', 'attr_5', 'attr_6', 'attr_7', 'attr_8', 'attr_9', 'attr_10', 'attr_11'],
        ['cont_1', 'cont_2', 'cont_3', 'cont_4', 'cont_5', 'cont_6', 'cont_7', 'cont_8', 'cont_9', 'cont_10', 'cont_11'],
        ['cont_1a', 'cont_2a', 'cont_3a', 'cont_4a', 'cont_5a', 'cont_6a', 'cont_7a', 'cont_8a', 'cont_9a', 'cont_10a', 'cont_11a']])
    @step_mother = Cucumber::Cli::Main.step_mother
    @step_mother.load_code_file(File.expand_path(File.dirname(__FILE__) + "/../../lib/common_steps/step_definitions/record_steps.rb"))
    @dsl = Object.new
    @dsl.extend(Cucumber::RbSupport::RbDsl)
    @step_mother.load_programming_language('rb').begin_rb_scenario
    @dsl.World(RecordHelper)
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
  
  it "there should be" do
    
  end
  
end
