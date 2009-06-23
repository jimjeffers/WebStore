require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/garment_sizes/show.html.erb" do
  include GarmentSizesHelper
  before(:each) do
    assigns[:garment_size] = @garment_size = stub_model(GarmentSize)
  end

  it "renders attributes in <p>" do
    render
  end
end

