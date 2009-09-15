# Specs from navigation_steps.rb
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../common_steps_helper')
require 'common_steps/helpers/record_helper'
require 'common_steps/helpers/navigation_helper'
require 'common_steps/helpers/step_mother_helper'


describe 'Cucumber instance with navigation_steps.rb and World(RecordHelper, NavigationHelper) loaded' do
  extend StepMotherHelper
  
  before do
    #include 'ruby-debug'
    #debugger
    @step_mother = Cucumber::Cli::Main.step_mother
    @step_mother.load_code_file(File.expand_path(File.dirname(__FILE__) + "/../../lib/common_steps/step_definitions/navigation_steps.rb"))

    @dsl = Object.new
    @dsl.extend(Cucumber::RbSupport::RbDsl)
    @dsl.World(RecordHelper, NavigationHelper) 
    @step_mother.load_programming_language('rb').begin_rb_scenario
    @current_world = Cucumber::RbSupport::RbDsl.instance_variable_get(:@rb_language).current_world
  end
  
  step_should_match 'I go to the homepage'
  step_should_match 'I go to "/asdkjasd/asdasd"'
  step_should_match 'I go to "asdkjasd/asdasd"'
  
  describe 'when I invoke homepage with homepage redirecting to "/"' do
    it 'should call homepage method' do
      @current_world.should_receive(:visit_homepage).with(no_args)
      m = @step_mother.step_match('I go to the homepage')
      m.invoke(nil)
    end
  end
  
  step_should_match 'I go to "/something.something/something"'
  
end
