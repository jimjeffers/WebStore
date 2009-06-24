require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/photos/show.html.erb" do
  include PhotosHelper
  before(:each) do
    assigns[:photo] = @photo = stub_model(Photo)
  end

  it "renders attributes in <p>" do
    render
  end
end

