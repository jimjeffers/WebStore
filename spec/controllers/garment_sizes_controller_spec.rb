require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GarmentSizesController do

  def mock_garment_size(stubs={})
    @mock_garment_size ||= mock_model(GarmentSize, stubs)
  end
  
  describe "GET index" do
    it "assigns all garment_sizes as @garment_sizes" do
      GarmentSize.stub!(:find).with(:all).and_return([mock_garment_size])
      get :index
      assigns[:garment_sizes].should == [mock_garment_size]
    end
  end

  describe "GET show" do
    it "assigns the requested garment_size as @garment_size" do
      GarmentSize.stub!(:find).with("37").and_return(mock_garment_size)
      get :show, :id => "37"
      assigns[:garment_size].should equal(mock_garment_size)
    end
  end

  describe "GET new" do
    it "assigns a new garment_size as @garment_size" do
      GarmentSize.stub!(:new).and_return(mock_garment_size)
      get :new
      assigns[:garment_size].should equal(mock_garment_size)
    end
  end

  describe "GET edit" do
    it "assigns the requested garment_size as @garment_size" do
      GarmentSize.stub!(:find).with("37").and_return(mock_garment_size)
      get :edit, :id => "37"
      assigns[:garment_size].should equal(mock_garment_size)
    end
  end

  describe "POST create" do
    
    describe "with valid params" do
      it "assigns a newly created garment_size as @garment_size" do
        GarmentSize.stub!(:new).with({'these' => 'params'}).and_return(mock_garment_size(:save => true))
        post :create, :garment_size => {:these => 'params'}
        assigns[:garment_size].should equal(mock_garment_size)
      end

      it "redirects to the created garment_size" do
        GarmentSize.stub!(:new).and_return(mock_garment_size(:save => true))
        post :create, :garment_size => {}
        response.should redirect_to(garment_size_url(mock_garment_size))
      end
    end
    
    describe "with invalid params" do
      it "assigns a newly created but unsaved garment_size as @garment_size" do
        GarmentSize.stub!(:new).with({'these' => 'params'}).and_return(mock_garment_size(:save => false))
        post :create, :garment_size => {:these => 'params'}
        assigns[:garment_size].should equal(mock_garment_size)
      end

      it "re-renders the 'new' template" do
        GarmentSize.stub!(:new).and_return(mock_garment_size(:save => false))
        post :create, :garment_size => {}
        response.should render_template('new')
      end
    end
    
  end

  describe "PUT update" do
    
    describe "with valid params" do
      it "updates the requested garment_size" do
        GarmentSize.should_receive(:find).with("37").and_return(mock_garment_size)
        mock_garment_size.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :garment_size => {:these => 'params'}
      end

      it "assigns the requested garment_size as @garment_size" do
        GarmentSize.stub!(:find).and_return(mock_garment_size(:update_attributes => true))
        put :update, :id => "1"
        assigns[:garment_size].should equal(mock_garment_size)
      end

      it "redirects to the garment_size" do
        GarmentSize.stub!(:find).and_return(mock_garment_size(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(garment_size_url(mock_garment_size))
      end
    end
    
    describe "with invalid params" do
      it "updates the requested garment_size" do
        GarmentSize.should_receive(:find).with("37").and_return(mock_garment_size)
        mock_garment_size.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :garment_size => {:these => 'params'}
      end

      it "assigns the garment_size as @garment_size" do
        GarmentSize.stub!(:find).and_return(mock_garment_size(:update_attributes => false))
        put :update, :id => "1"
        assigns[:garment_size].should equal(mock_garment_size)
      end

      it "re-renders the 'edit' template" do
        GarmentSize.stub!(:find).and_return(mock_garment_size(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end
    
  end

  describe "DELETE destroy" do
    it "destroys the requested garment_size" do
      GarmentSize.should_receive(:find).with("37").and_return(mock_garment_size)
      mock_garment_size.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "redirects to the garment_sizes list" do
      GarmentSize.stub!(:find).and_return(mock_garment_size(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(garment_sizes_url)
    end
  end

end
