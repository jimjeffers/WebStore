require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/variations/edit.html.erb" do
  include VariationsHelper
  
  before(:each) do
    assigns[:variation] = @variation = stub_model(Variation,
      :new_record? => false
    )
  end

  it "renders the edit variation form" do
    render
    
    response.should have_tag("form[action=#{variation_path(@variation)}][method=post]") do
    end
  end
end


