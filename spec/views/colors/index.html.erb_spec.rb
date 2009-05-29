require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/colors/index.html.erb" do
  include ColorsHelper
  
  before(:each) do
    assigns[:colors] = [
      stub_model(Color),
      stub_model(Color)
    ]
  end

  it "renders a list of colors" do
    render
  end
end

