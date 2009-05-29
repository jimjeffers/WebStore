require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/colors/new.html.erb" do
  include ColorsHelper
  
  before(:each) do
    assigns[:color] = stub_model(Color,
      :new_record? => true
    )
  end

  it "renders new color form" do
    render
    
    response.should have_tag("form[action=?][method=post]", colors_path) do
    end
  end
end


