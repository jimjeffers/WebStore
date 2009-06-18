require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe VariationsController do

  def mock_variation(stubs={})
    @mock_variation ||= mock_model(Variation, stubs)
  end
  
  describe "GET index" do
    it "assigns all variations as @variations" do
      Variation.stub!(:find).with(:all).and_return([mock_variation])
      get :index
      assigns[:variations].should == [mock_variation]
    end
  end

  describe "GET show" do
    it "assigns the requested variation as @variation" do
      Variation.stub!(:find).with("37").and_return(mock_variation)
      get :show, :id => "37"
      assigns[:variation].should equal(mock_variation)
    end
  end

  describe "GET new" do
    it "assigns a new variation as @variation" do
      Variation.stub!(:new).and_return(mock_variation)
      get :new
      assigns[:variation].should equal(mock_variation)
    end
  end

  describe "GET edit" do
    it "assigns the requested variation as @variation" do
      Variation.stub!(:find).with("37").and_return(mock_variation)
      get :edit, :id => "37"
      assigns[:variation].should equal(mock_variation)
    end
  end

  describe "POST create" do
    
    describe "with valid params" do
      it "assigns a newly created variation as @variation" do
        Variation.stub!(:new).with({'these' => 'params'}).and_return(mock_variation(:save => true))
        post :create, :variation => {:these => 'params'}
        assigns[:variation].should equal(mock_variation)
      end

      it "redirects to the created variation" do
        Variation.stub!(:new).and_return(mock_variation(:save => true))
        post :create, :variation => {}
        response.should redirect_to(variation_url(mock_variation))
      end
    end
    
    describe "with invalid params" do
      it "assigns a newly created but unsaved variation as @variation" do
        Variation.stub!(:new).with({'these' => 'params'}).and_return(mock_variation(:save => false))
        post :create, :variation => {:these => 'params'}
        assigns[:variation].should equal(mock_variation)
      end

      it "re-renders the 'new' template" do
        Variation.stub!(:new).and_return(mock_variation(:save => false))
        post :create, :variation => {}
        response.should render_template('new')
      end
    end
    
  end

  describe "PUT update" do
    
    describe "with valid params" do
      it "updates the requested variation" do
        Variation.should_receive(:find).with("37").and_return(mock_variation)
        mock_variation.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :variation => {:these => 'params'}
      end

      it "assigns the requested variation as @variation" do
        Variation.stub!(:find).and_return(mock_variation(:update_attributes => true))
        put :update, :id => "1"
        assigns[:variation].should equal(mock_variation)
      end

      it "redirects to the variation" do
        Variation.stub!(:find).and_return(mock_variation(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(variation_url(mock_variation))
      end
    end
    
    describe "with invalid params" do
      it "updates the requested variation" do
        Variation.should_receive(:find).with("37").and_return(mock_variation)
        mock_variation.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :variation => {:these => 'params'}
      end

      it "assigns the variation as @variation" do
        Variation.stub!(:find).and_return(mock_variation(:update_attributes => false))
        put :update, :id => "1"
        assigns[:variation].should equal(mock_variation)
      end

      it "re-renders the 'edit' template" do
        Variation.stub!(:find).and_return(mock_variation(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end
    
  end

  describe "DELETE destroy" do
    it "destroys the requested variation" do
      Variation.should_receive(:find).with("37").and_return(mock_variation)
      mock_variation.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "redirects to the variations list" do
      Variation.stub!(:find).and_return(mock_variation(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(variations_url)
    end
  end

end
