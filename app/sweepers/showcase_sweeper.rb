class ShowcaseSweeper < ActionController::Caching::Sweeper
  observe :categorization, :product, :site_setting, :category
  
  def after_save(categorization)
    expire_cache()
  end
  
  def after_update(categorization)
    expire_cache()
  end
  
  def after_destroy(categorization)
    expire_cache()
  end
  
  def expire_cache()
    10.times do |page_number|
      expire_fragment(:controller => 'layout', :action => 'store', :action_suffix => "product_showcase_page_#{page_number}")
    end
  end
end