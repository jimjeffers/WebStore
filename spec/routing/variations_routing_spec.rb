require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe VariationsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "variations", :action => "index").should == "/variations"
    end
  
    it "maps #new" do
      route_for(:controller => "variations", :action => "new").should == "/variations/new"
    end
  
    it "maps #show" do
      route_for(:controller => "variations", :action => "show", :id => "1").should == "/variations/1"
    end
  
    it "maps #edit" do
      route_for(:controller => "variations", :action => "edit", :id => "1").should == "/variations/1/edit"
    end

  it "maps #create" do
    route_for(:controller => "variations", :action => "create").should == {:path => "/variations", :method => :post}
  end

  it "maps #update" do
    route_for(:controller => "variations", :action => "update", :id => "1").should == {:path =>"/variations/1", :method => :put}
  end
  
    it "maps #destroy" do
      route_for(:controller => "variations", :action => "destroy", :id => "1").should == {:path =>"/variations/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/variations").should == {:controller => "variations", :action => "index"}
    end
  
    it "generates params for #new" do
      params_from(:get, "/variations/new").should == {:controller => "variations", :action => "new"}
    end
  
    it "generates params for #create" do
      params_from(:post, "/variations").should == {:controller => "variations", :action => "create"}
    end
  
    it "generates params for #show" do
      params_from(:get, "/variations/1").should == {:controller => "variations", :action => "show", :id => "1"}
    end
  
    it "generates params for #edit" do
      params_from(:get, "/variations/1/edit").should == {:controller => "variations", :action => "edit", :id => "1"}
    end
  
    it "generates params for #update" do
      params_from(:put, "/variations/1").should == {:controller => "variations", :action => "update", :id => "1"}
    end
  
    it "generates params for #destroy" do
      params_from(:delete, "/variations/1").should == {:controller => "variations", :action => "destroy", :id => "1"}
    end
  end
end
