require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/products/edit.html.erb" do
  include ProductsHelper
  
  before(:each) do
    assigns[:product] = @product = stub_model(Product,
      :new_record? => false
    )
  end

  it "renders the edit product form" do
    render
    
    response.should have_tag("form[action=#{product_path(@product)}][method=post]") do
    end
  end
end


