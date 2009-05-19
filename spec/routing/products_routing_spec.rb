require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProductsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "products", :action => "index").should == "/products"
    end
  
    it "maps #new" do
      route_for(:controller => "products", :action => "new").should == "/products/new"
    end
  
    it "maps #show" do
      route_for(:controller => "products", :action => "show", :id => "1").should == "/products/1"
    end
  
    it "maps #edit" do
      route_for(:controller => "products", :action => "edit", :id => "1").should == "/products/1/edit"
    end

  it "maps #create" do
    route_for(:controller => "products", :action => "create").should == {:path => "/products", :method => :post}
  end

  it "maps #update" do
    route_for(:controller => "products", :action => "update", :id => "1").should == {:path =>"/products/1", :method => :put}
  end
  
    it "maps #destroy" do
      route_for(:controller => "products", :action => "destroy", :id => "1").should == {:path =>"/products/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/products").should == {:controller => "products", :action => "index"}
    end
  
    it "generates params for #new" do
      params_from(:get, "/products/new").should == {:controller => "products", :action => "new"}
    end
  
    it "generates params for #create" do
      params_from(:post, "/products").should == {:controller => "products", :action => "create"}
    end
  
    it "generates params for #show" do
      params_from(:get, "/products/1").should == {:controller => "products", :action => "show", :id => "1"}
    end
  
    it "generates params for #edit" do
      params_from(:get, "/products/1/edit").should == {:controller => "products", :action => "edit", :id => "1"}
    end
  
    it "generates params for #update" do
      params_from(:put, "/products/1").should == {:controller => "products", :action => "update", :id => "1"}
    end
  
    it "generates params for #destroy" do
      params_from(:delete, "/products/1").should == {:controller => "products", :action => "destroy", :id => "1"}
    end
  end
end
