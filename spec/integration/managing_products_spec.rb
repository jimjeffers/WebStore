require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Managing Products" do
  before(:each) do
    @valid_attributes = {
    }
  end

  describe "viewing index" do
    it "lists all Products" do
      product = Product.create!(@valid_attributes)
      visit products_path
      response.should have_selector("a", :href => product_path(product))
    end
  end
end
