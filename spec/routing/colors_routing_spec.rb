require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ColorsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "colors", :action => "index").should == "/colors"
    end
  
    it "maps #new" do
      route_for(:controller => "colors", :action => "new").should == "/colors/new"
    end
  
    it "maps #show" do
      route_for(:controller => "colors", :action => "show", :id => "1").should == "/colors/1"
    end
  
    it "maps #edit" do
      route_for(:controller => "colors", :action => "edit", :id => "1").should == "/colors/1/edit"
    end

  it "maps #create" do
    route_for(:controller => "colors", :action => "create").should == {:path => "/colors", :method => :post}
  end

  it "maps #update" do
    route_for(:controller => "colors", :action => "update", :id => "1").should == {:path =>"/colors/1", :method => :put}
  end
  
    it "maps #destroy" do
      route_for(:controller => "colors", :action => "destroy", :id => "1").should == {:path =>"/colors/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/colors").should == {:controller => "colors", :action => "index"}
    end
  
    it "generates params for #new" do
      params_from(:get, "/colors/new").should == {:controller => "colors", :action => "new"}
    end
  
    it "generates params for #create" do
      params_from(:post, "/colors").should == {:controller => "colors", :action => "create"}
    end
  
    it "generates params for #show" do
      params_from(:get, "/colors/1").should == {:controller => "colors", :action => "show", :id => "1"}
    end
  
    it "generates params for #edit" do
      params_from(:get, "/colors/1/edit").should == {:controller => "colors", :action => "edit", :id => "1"}
    end
  
    it "generates params for #update" do
      params_from(:put, "/colors/1").should == {:controller => "colors", :action => "update", :id => "1"}
    end
  
    it "generates params for #destroy" do
      params_from(:delete, "/colors/1").should == {:controller => "colors", :action => "destroy", :id => "1"}
    end
  end
end
