require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/colors/edit.html.erb" do
  include ColorsHelper
  
  before(:each) do
    assigns[:color] = @color = stub_model(Color,
      :new_record? => false
    )
  end

  it "renders the edit color form" do
    render
    
    response.should have_tag("form[action=#{color_path(@color)}][method=post]") do
    end
  end
end


