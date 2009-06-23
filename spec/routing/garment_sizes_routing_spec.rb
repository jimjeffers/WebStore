require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GarmentSizesController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "garment_sizes", :action => "index").should == "/garment_sizes"
    end
  
    it "maps #new" do
      route_for(:controller => "garment_sizes", :action => "new").should == "/garment_sizes/new"
    end
  
    it "maps #show" do
      route_for(:controller => "garment_sizes", :action => "show", :id => "1").should == "/garment_sizes/1"
    end
  
    it "maps #edit" do
      route_for(:controller => "garment_sizes", :action => "edit", :id => "1").should == "/garment_sizes/1/edit"
    end

  it "maps #create" do
    route_for(:controller => "garment_sizes", :action => "create").should == {:path => "/garment_sizes", :method => :post}
  end

  it "maps #update" do
    route_for(:controller => "garment_sizes", :action => "update", :id => "1").should == {:path =>"/garment_sizes/1", :method => :put}
  end
  
    it "maps #destroy" do
      route_for(:controller => "garment_sizes", :action => "destroy", :id => "1").should == {:path =>"/garment_sizes/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/garment_sizes").should == {:controller => "garment_sizes", :action => "index"}
    end
  
    it "generates params for #new" do
      params_from(:get, "/garment_sizes/new").should == {:controller => "garment_sizes", :action => "new"}
    end
  
    it "generates params for #create" do
      params_from(:post, "/garment_sizes").should == {:controller => "garment_sizes", :action => "create"}
    end
  
    it "generates params for #show" do
      params_from(:get, "/garment_sizes/1").should == {:controller => "garment_sizes", :action => "show", :id => "1"}
    end
  
    it "generates params for #edit" do
      params_from(:get, "/garment_sizes/1/edit").should == {:controller => "garment_sizes", :action => "edit", :id => "1"}
    end
  
    it "generates params for #update" do
      params_from(:put, "/garment_sizes/1").should == {:controller => "garment_sizes", :action => "update", :id => "1"}
    end
  
    it "generates params for #destroy" do
      params_from(:delete, "/garment_sizes/1").should == {:controller => "garment_sizes", :action => "destroy", :id => "1"}
    end
  end
end
