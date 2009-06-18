require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Managing Variations" do
  before(:each) do
    @valid_attributes = {
    }
  end

  describe "viewing index" do
    it "lists all Variations" do
      variation = Variation.create!(@valid_attributes)
      visit variations_path
      response.should have_selector("a", :href => variation_path(variation))
    end
  end
end
