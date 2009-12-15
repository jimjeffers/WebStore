require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Store do
  
  it "should have shipping methods" do
    Store::SHIPPING_METHODS.nil?.should be(false)
  end
  
  it "should have a max quantity" do
    Store::MAX_QUANTITY.nil?.should be(false)
  end
  
  it "should have a sales tax rate of 8.1%" do
    (Store::SALES_TAX_RATE == 0.081).should be(true)
  end
  
  it "should have a shipping minimum" do
    Store::SHIPPING_MINIMUM.nil?.should be(false)
  end
  
  describe "calculate_shipping_cost" do
    it "should return $6 if $15 is ordered." do
      Store.calculate_shipping_cost(15).should be(6)
    end
    it "should return $8 if $48 is ordered." do
      Store.calculate_shipping_cost(48).should be(8)
    end
    it "should return $18 if $250 is ordered." do
      Store.calculate_shipping_cost(250).should be(18)
    end
  end
end