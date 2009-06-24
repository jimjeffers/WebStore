require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PhotosController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "photos", :action => "index").should == "/photos"
    end
  
    it "maps #new" do
      route_for(:controller => "photos", :action => "new").should == "/photos/new"
    end
  
    it "maps #show" do
      route_for(:controller => "photos", :action => "show", :id => "1").should == "/photos/1"
    end
  
    it "maps #edit" do
      route_for(:controller => "photos", :action => "edit", :id => "1").should == "/photos/1/edit"
    end

  it "maps #create" do
    route_for(:controller => "photos", :action => "create").should == {:path => "/photos", :method => :post}
  end

  it "maps #update" do
    route_for(:controller => "photos", :action => "update", :id => "1").should == {:path =>"/photos/1", :method => :put}
  end
  
    it "maps #destroy" do
      route_for(:controller => "photos", :action => "destroy", :id => "1").should == {:path =>"/photos/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/photos").should == {:controller => "photos", :action => "index"}
    end
  
    it "generates params for #new" do
      params_from(:get, "/photos/new").should == {:controller => "photos", :action => "new"}
    end
  
    it "generates params for #create" do
      params_from(:post, "/photos").should == {:controller => "photos", :action => "create"}
    end
  
    it "generates params for #show" do
      params_from(:get, "/photos/1").should == {:controller => "photos", :action => "show", :id => "1"}
    end
  
    it "generates params for #edit" do
      params_from(:get, "/photos/1/edit").should == {:controller => "photos", :action => "edit", :id => "1"}
    end
  
    it "generates params for #update" do
      params_from(:put, "/photos/1").should == {:controller => "photos", :action => "update", :id => "1"}
    end
  
    it "generates params for #destroy" do
      params_from(:delete, "/photos/1").should == {:controller => "photos", :action => "destroy", :id => "1"}
    end
  end
end
