ActionController::Routing::Routes.draw do |map|

  map.resources :products do |product|
    product.resources :variations
  end
  map.product_remove_category '/products/:product_id/remove/category/:category_id', :controller => 'products', :action => 'remove_category'
  map.product_add_category    '/products/:product_id/add/category/:category_id', :controller => 'products', :action => 'add_category'
  map.product_search '/products/search/', :controller => 'products', :action => 'search'
  
  map.resources :categories do |category|
    category.resources :products
  end

  map.resource  :session
  map.resources :brands
  map.resources :colors
  map.resources :garment_sizes
  
  map.logout    '/logout',    :controller => 'sessions',  :action => 'destroy'
  map.login     '/login',     :controller => 'sessions',  :action => 'new'
  map.register  '/register',  :controller => 'users',     :action => 'create'
  map.signup    '/signup',    :controller => 'users',     :action => 'new'
  
  map.resources :users, :member => { :suspend   => :put,
                                     :unsuspend => :put,
                                     :purge     => :delete }
                                     
  map.user_add_role '/user/:user_id/add/role/:role_id', :controller => 'users', :action => 'add_role'
  map.user_remove_role '/user/:user_id/remove/role/:role_id', :controller => 'users', :action => 'remove_role'
  
  map.browse_brand '/brand/:guid', :controller => 'store', :action => 'brand'
  map.browse_category '/browse/:guid', :controller => 'store', :action => 'category'
  
  map.add_to_cart '/cart/add/:id', :controller => 'store', :action => 'add_to_cart'
  map.remove_from_card '/cart/remove/:id', :controller => 'store', :action => 'remove_from_cart'
  map.empty_cart 'cart/empty', :controller => 'store', :action => 'empty'
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.connect '/', :controller => 'store', :action => 'index'
end
