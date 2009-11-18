module StoreHelper
  # Grabs the default path for a given item.
  def item_path_or_default(method,category,product)
    method = product.method if method.nil?
    category = product.categories.first if category.nil?
    path = browse_item_path(method,category.guid,product.guid)
    path || nil
  end
end
