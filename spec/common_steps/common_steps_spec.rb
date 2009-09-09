require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module StepDefinitionHelper
  def Given(regexp)
  end
  def When(regexp)
  end
  def Then(regexp)
  end
end

describe "require 'common_steps'", "with Given, When, and Then methods defined on Object" do
  before do
    Object.send(:include, StepDefinitionHelper)
  end
  
  it "should define RecordHelper" do
    load 'common_steps.rb'
    defined?(RecordHelper).should be_true
  end
end

describe "require 'common_steps'", "with Given, When, Then, and World method defined on Object" do
end
