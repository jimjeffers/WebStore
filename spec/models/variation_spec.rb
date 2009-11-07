require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Variation do
  before(:each) do
    @variation = Factory.build(:variation)
  end

  it "should create a new instance given valid attributes" do
    @variation.save.should be(true)
  end
end
