require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Managing Photos" do
  before(:each) do
    @valid_attributes = {
    }
  end

  describe "viewing index" do
    it "lists all Photos" do
      photo = Photo.create!(@valid_attributes)
      visit photos_path
      response.should have_selector("a", :href => photo_path(photo))
    end
  end
end
