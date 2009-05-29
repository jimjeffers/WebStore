require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/colors/show.html.erb" do
  include ColorsHelper
  before(:each) do
    assigns[:color] = @color = stub_model(Color)
  end

  it "renders attributes in <p>" do
    render
  end
end

