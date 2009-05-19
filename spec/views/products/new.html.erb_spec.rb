require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/products/new.html.erb" do
  include ProductsHelper
  
  before(:each) do
    assigns[:product] = stub_model(Product,
      :new_record? => true
    )
  end

  it "renders new product form" do
    render
    
    response.should have_tag("form[action=?][method=post]", products_path) do
    end
  end
end


