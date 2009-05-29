require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Managing Colors" do
  before(:each) do
    @valid_attributes = {
    }
  end

  describe "viewing index" do
    it "lists all Colors" do
      color = Color.create!(@valid_attributes)
      visit colors_path
      response.should have_selector("a", :href => color_path(color))
    end
  end
end
