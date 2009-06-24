require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/photos/index.html.erb" do
  include PhotosHelper
  
  before(:each) do
    assigns[:photos] = [
      stub_model(Photo),
      stub_model(Photo)
    ]
  end

  it "renders a list of photos" do
    render
  end
end

