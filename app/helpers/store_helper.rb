module StoreHelper
  def item_path_or_default(method,category,product)
    method = product.variations.first.garment_size.gender.downcase if method.nil?
    category = product.categories.first if category.nil?
    browse_item_path(method,category.guid,product.guid)
  end
end
