require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Order do
  before(:each) do
    @cart = Factory.build(:cart)
    @shirt = Factory.create(:product_shirt, :price => 20.00)
    @shorts = Factory.create(:product_shorts, :price => 40.00)
    @variation_1 = Factory.create(:variation, :product => @shirt, :sku => "ASU-450")
    @variation_2 = Factory.create(:variation, :product => @shorts, :sku => "ASU-451")
    @line_item_1 = Factory.create(:line_item, :variation => @variation_1, :quantity => 1)
    @line_item_2 = Factory.create(:line_item, :variation => @variation_2, :quantity => 1)
  end
  
  describe "calculate_cart" do
    before(:each) do
      @cart.save
      @cart.line_items << @line_item_1
      @cart.line_items << @line_item_2
      
      @order = Factory.build(:order)
      @order_shipping_out = Factory.build(:order_with_shipping_outside_of_az)
      @order_billing_out = Factory.build(:order_with_billing_outside_of_az)
      @order_both_out = Factory.build(:order_with_shipping_and_billing_outside_of_az)
      @order_with_second_day = Factory.build(:order_with_second_day)
    end
      
    it "should have sales tax of 4.86 if both the shipping and billing address are in AZ" do
      @order.calculate_cart(@cart)
      @order.sales_tax.should be(486)
    end
    
    it "should have no sales tax if the shipping is outside of AZ" do
      @order_shipping_out.calculate_cart(@cart)
      @order_shipping_out.sales_tax.should be(0)
    end
    
    it "should have no sales tax if the billing is outside of AZ" do
      @order_billing_out.calculate_cart(@cart)
      @order_billing_out.sales_tax.should be(0)
    end
    
    it "should have no sales tax if the billing and shipping are outside of AZ" do
      @order_both_out.calculate_cart(@cart)
      @order_both_out.sales_tax.should be(0)
    end
    
    it "should have a shipping cost of 800" do
      @order.calculate_cart(@cart)
      @order.shipping_cost.should be(900)
    end
    
    it "should have a shipping cost of 2600 if 2nd day was chosen" do
      @order_with_second_day.calculate_cart(@cart)
      @order_with_second_day.shipping_cost.should be(2700)
    end
  end
end