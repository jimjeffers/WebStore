require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Cart do
  before(:each) do
    @cart = Factory.build(:cart)
    @shirt = Factory.create(:product_shirt, :price => 20.00)
    @shorts = Factory.create(:product_shorts, :price => 40.00)
    @variation_1 = Factory.create(:variation, :product => @shirt, :sku => "ASU-450")
    @variation_2 = Factory.create(:variation, :product => @shorts, :sku => "ASU-451")
    @line_item_1 = Factory.create(:line_item, :variation => @variation_1, :quantity => 1)
    @line_item_2 = Factory.create(:line_item, :variation => @variation_2, :quantity => 1)
  end
  
  it "should save a valid instance" do
    @cart.save.should be(true)
  end
  
  it "should have a 40 character cart_token upon creation" do
    @cart.save
    @cart.cart_token.length.should be(40)
  end
  
  describe "running_total" do
    before(:each) do
      @cart.save
      @cart.line_items << @line_item_1
      @cart.line_items << @line_item_2
    end
    
    it "should have a running_total of $60.00 with a pair of shorts and a shirt in the cart" do
      (@cart.running_total == 60.00).should be(true)
    end
    
    it "should have a running_total of $120.00 with a pair of shorts and 4 shirts in the cart" do
      @line_item_1.update_attribute(:quantity,4)
      (@cart.running_total == 120.00).should be(true)
    end
    
    it "should have a running_total of $40.00 with a pair of shorts and 0 shirts in the cart" do
      @line_item_1.update_attribute(:quantity,0)
      (@cart.running_total == 40.00).should be(true)
    end
    
    it "should have a running_total of $0.00 with 0 pairs of shorts and 0 shirts in the cart" do
      @line_item_1.update_attribute(:quantity,0)
      @line_item_2.update_attribute(:quantity,0)
      (@cart.running_total == 0.00).should be(true)
    end
  end
  
  describe "item_count" do
    before(:each) do
      @cart.save
      @cart.line_items << @line_item_1
      @cart.line_items << @line_item_2
    end
    
    it "should return 2 when there is a pair of shorts and a shirt in the cart" do
      @cart.item_count.should be(2)
    end
    
    it "should return 3 when there are 2 pairs of shorts and a shirt in the cart" do
      @line_item_2.update_attribute(:quantity,2)
      @cart.item_count.should be(3)
    end
    
    it "should return 10 when there are 5 pairs of shorts and 5 shirts in the cart" do
      @line_item_1.update_attribute(:quantity,5)
      @line_item_2.update_attribute(:quantity,5)
      @cart.item_count.should be(10)
    end
    
    it "should return 0 when there are 0 pairs of shorts and 0 shirts in the cart" do
      @line_item_1.update_attribute(:quantity,0)
      @line_item_2.update_attribute(:quantity,0)
      @cart.item_count.should be(0)
    end
    
    it "should return 0 when there are no line items assigned to the cart" do
      @cart.line_items.delete(@line_item_1)
      @cart.line_items.delete(@line_item_2)
      @cart.item_count.should be(0)
    end
    
    it "should return 0 if the cart is new and empty" do
      Factory.create(:cart).item_count.should be(0)
    end
  end
end