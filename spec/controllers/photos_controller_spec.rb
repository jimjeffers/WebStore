require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PhotosController do

  def mock_photo(stubs={})
    @mock_photo ||= mock_model(Photo, stubs)
  end
  
  describe "GET index" do
    it "assigns all photos as @photos" do
      Photo.stub!(:find).with(:all).and_return([mock_photo])
      get :index
      assigns[:photos].should == [mock_photo]
    end
  end

  describe "GET show" do
    it "assigns the requested photo as @photo" do
      Photo.stub!(:find).with("37").and_return(mock_photo)
      get :show, :id => "37"
      assigns[:photo].should equal(mock_photo)
    end
  end

  describe "GET new" do
    it "assigns a new photo as @photo" do
      Photo.stub!(:new).and_return(mock_photo)
      get :new
      assigns[:photo].should equal(mock_photo)
    end
  end

  describe "GET edit" do
    it "assigns the requested photo as @photo" do
      Photo.stub!(:find).with("37").and_return(mock_photo)
      get :edit, :id => "37"
      assigns[:photo].should equal(mock_photo)
    end
  end

  describe "POST create" do
    
    describe "with valid params" do
      it "assigns a newly created photo as @photo" do
        Photo.stub!(:new).with({'these' => 'params'}).and_return(mock_photo(:save => true))
        post :create, :photo => {:these => 'params'}
        assigns[:photo].should equal(mock_photo)
      end

      it "redirects to the created photo" do
        Photo.stub!(:new).and_return(mock_photo(:save => true))
        post :create, :photo => {}
        response.should redirect_to(photo_url(mock_photo))
      end
    end
    
    describe "with invalid params" do
      it "assigns a newly created but unsaved photo as @photo" do
        Photo.stub!(:new).with({'these' => 'params'}).and_return(mock_photo(:save => false))
        post :create, :photo => {:these => 'params'}
        assigns[:photo].should equal(mock_photo)
      end

      it "re-renders the 'new' template" do
        Photo.stub!(:new).and_return(mock_photo(:save => false))
        post :create, :photo => {}
        response.should render_template('new')
      end
    end
    
  end

  describe "PUT update" do
    
    describe "with valid params" do
      it "updates the requested photo" do
        Photo.should_receive(:find).with("37").and_return(mock_photo)
        mock_photo.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :photo => {:these => 'params'}
      end

      it "assigns the requested photo as @photo" do
        Photo.stub!(:find).and_return(mock_photo(:update_attributes => true))
        put :update, :id => "1"
        assigns[:photo].should equal(mock_photo)
      end

      it "redirects to the photo" do
        Photo.stub!(:find).and_return(mock_photo(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(photo_url(mock_photo))
      end
    end
    
    describe "with invalid params" do
      it "updates the requested photo" do
        Photo.should_receive(:find).with("37").and_return(mock_photo)
        mock_photo.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :photo => {:these => 'params'}
      end

      it "assigns the photo as @photo" do
        Photo.stub!(:find).and_return(mock_photo(:update_attributes => false))
        put :update, :id => "1"
        assigns[:photo].should equal(mock_photo)
      end

      it "re-renders the 'edit' template" do
        Photo.stub!(:find).and_return(mock_photo(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end
    
  end

  describe "DELETE destroy" do
    it "destroys the requested photo" do
      Photo.should_receive(:find).with("37").and_return(mock_photo)
      mock_photo.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "redirects to the photos list" do
      Photo.stub!(:find).and_return(mock_photo(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(photos_url)
    end
  end

end
