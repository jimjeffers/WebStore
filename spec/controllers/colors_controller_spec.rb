require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ColorsController do

  def mock_color(stubs={})
    @mock_color ||= mock_model(Color, stubs)
  end
  
  describe "GET index" do
    it "assigns all colors as @colors" do
      Color.stub!(:find).with(:all).and_return([mock_color])
      get :index
      assigns[:colors].should == [mock_color]
    end
  end

  describe "GET show" do
    it "assigns the requested color as @color" do
      Color.stub!(:find).with("37").and_return(mock_color)
      get :show, :id => "37"
      assigns[:color].should equal(mock_color)
    end
  end

  describe "GET new" do
    it "assigns a new color as @color" do
      Color.stub!(:new).and_return(mock_color)
      get :new
      assigns[:color].should equal(mock_color)
    end
  end

  describe "GET edit" do
    it "assigns the requested color as @color" do
      Color.stub!(:find).with("37").and_return(mock_color)
      get :edit, :id => "37"
      assigns[:color].should equal(mock_color)
    end
  end

  describe "POST create" do
    
    describe "with valid params" do
      it "assigns a newly created color as @color" do
        Color.stub!(:new).with({'these' => 'params'}).and_return(mock_color(:save => true))
        post :create, :color => {:these => 'params'}
        assigns[:color].should equal(mock_color)
      end

      it "redirects to the created color" do
        Color.stub!(:new).and_return(mock_color(:save => true))
        post :create, :color => {}
        response.should redirect_to(color_url(mock_color))
      end
    end
    
    describe "with invalid params" do
      it "assigns a newly created but unsaved color as @color" do
        Color.stub!(:new).with({'these' => 'params'}).and_return(mock_color(:save => false))
        post :create, :color => {:these => 'params'}
        assigns[:color].should equal(mock_color)
      end

      it "re-renders the 'new' template" do
        Color.stub!(:new).and_return(mock_color(:save => false))
        post :create, :color => {}
        response.should render_template('new')
      end
    end
    
  end

  describe "PUT update" do
    
    describe "with valid params" do
      it "updates the requested color" do
        Color.should_receive(:find).with("37").and_return(mock_color)
        mock_color.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :color => {:these => 'params'}
      end

      it "assigns the requested color as @color" do
        Color.stub!(:find).and_return(mock_color(:update_attributes => true))
        put :update, :id => "1"
        assigns[:color].should equal(mock_color)
      end

      it "redirects to the color" do
        Color.stub!(:find).and_return(mock_color(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(color_url(mock_color))
      end
    end
    
    describe "with invalid params" do
      it "updates the requested color" do
        Color.should_receive(:find).with("37").and_return(mock_color)
        mock_color.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :color => {:these => 'params'}
      end

      it "assigns the color as @color" do
        Color.stub!(:find).and_return(mock_color(:update_attributes => false))
        put :update, :id => "1"
        assigns[:color].should equal(mock_color)
      end

      it "re-renders the 'edit' template" do
        Color.stub!(:find).and_return(mock_color(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end
    
  end

  describe "DELETE destroy" do
    it "destroys the requested color" do
      Color.should_receive(:find).with("37").and_return(mock_color)
      mock_color.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "redirects to the colors list" do
      Color.stub!(:find).and_return(mock_color(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(colors_url)
    end
  end

end
