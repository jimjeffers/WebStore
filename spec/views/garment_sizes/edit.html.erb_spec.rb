require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/garment_sizes/edit.html.erb" do
  include GarmentSizesHelper
  
  before(:each) do
    assigns[:garment_size] = @garment_size = stub_model(GarmentSize,
      :new_record? => false
    )
  end

  it "renders the edit garment_size form" do
    render
    
    response.should have_tag("form[action=#{garment_size_path(@garment_size)}][method=post]") do
    end
  end
end


