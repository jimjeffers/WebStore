require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/garment_sizes/new.html.erb" do
  include GarmentSizesHelper
  
  before(:each) do
    assigns[:garment_size] = stub_model(GarmentSize,
      :new_record? => true
    )
  end

  it "renders new garment_size form" do
    render
    
    response.should have_tag("form[action=?][method=post]", garment_sizes_path) do
    end
  end
end


