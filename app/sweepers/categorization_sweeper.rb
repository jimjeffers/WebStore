class CategorizationSweeper < ActionController::Caching::Sweeper
  observe :categorization, :product, :variation, :category
  
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
    expire_fragment(:controller => 'layout', :action => 'store', :action_suffix =>"store_layout_search_and_nav")
    expire_fragment(:controller => 'layout', :action => 'store', :action_suffix =>"store_layout_footer")
    expire_fragment(:controller => 'layout', :action => 'store', :action_suffix => "section_navigation")
  end
end