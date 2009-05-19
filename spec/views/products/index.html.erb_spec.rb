require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/products/index.html.erb" do
  include ProductsHelper
  
  before(:each) do
    assigns[:products] = [
      stub_model(Product),
      stub_model(Product)
    ]
  end

  it "renders a list of products" do
    render
  end
end

