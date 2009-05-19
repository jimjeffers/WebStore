require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Managing Categories" do
  before(:each) do
    @valid_attributes = {
    }
  end

  describe "viewing index" do
    it "lists all Categories" do
      category = Category.create!(@valid_attributes)
      visit categories_path
      response.should have_selector("a", :href => category_path(category))
    end
  end
end
