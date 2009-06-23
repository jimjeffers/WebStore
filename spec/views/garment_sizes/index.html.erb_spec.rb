require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/garment_sizes/index.html.erb" do
  include GarmentSizesHelper
  
  before(:each) do
    assigns[:garment_sizes] = [
      stub_model(GarmentSize),
      stub_model(GarmentSize)
    ]
  end

  it "renders a list of garment_sizes" do
    render
  end
end

