require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Managing GarmentSizes" do
  before(:each) do
    @valid_attributes = {
    }
  end

  describe "viewing index" do
    it "lists all GarmentSizes" do
      garment_size = GarmentSize.create!(@valid_attributes)
      visit garment_sizes_path
      response.should have_selector("a", :href => garment_size_path(garment_size))
    end
  end
end
