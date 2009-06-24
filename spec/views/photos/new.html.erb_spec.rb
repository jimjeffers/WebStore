require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/photos/new.html.erb" do
  include PhotosHelper
  
  before(:each) do
    assigns[:photo] = stub_model(Photo,
      :new_record? => true
    )
  end

  it "renders new photo form" do
    render
    
    response.should have_tag("form[action=?][method=post]", photos_path) do
    end
  end
end


