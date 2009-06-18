require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/variations/show.html.erb" do
  include VariationsHelper
  before(:each) do
    assigns[:variation] = @variation = stub_model(Variation)
  end

  it "renders attributes in <p>" do
    render
  end
end

