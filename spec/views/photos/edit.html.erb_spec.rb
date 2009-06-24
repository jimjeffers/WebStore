require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/photos/edit.html.erb" do
  include PhotosHelper
  
  before(:each) do
    assigns[:photo] = @photo = stub_model(Photo,
      :new_record? => false
    )
  end

  it "renders the edit photo form" do
    render
    
    response.should have_tag("form[action=#{photo_path(@photo)}][method=post]") do
    end
  end
end


