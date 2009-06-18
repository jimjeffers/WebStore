require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/variations/index.html.erb" do
  include VariationsHelper
  
  before(:each) do
    assigns[:variations] = [
      stub_model(Variation),
      stub_model(Variation)
    ]
  end

  it "renders a list of variations" do
    render
  end
end

