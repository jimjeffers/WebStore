require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/variations/new.html.erb" do
  include VariationsHelper
  
  before(:each) do
    assigns[:variation] = stub_model(Variation,
      :new_record? => true
    )
  end

  it "renders new variation form" do
    render
    
    response.should have_tag("form[action=?][method=post]", variations_path) do
    end
  end
end


