ActionController::Routing::Routes.draw do |map|
  
  map.sort_products '/products/sort', :controller => 'products', :action => 'sort'
  map.sort_products_in_category '/products/sort/category/:category_id', :controller => 'products', :action => 'sort'
  map.update_order_of_products '/products/update_order', :controller => 'products', :action => 'update_order'
  map.update_order_of_categorizations '/categorizations/update_order', :controller => 'products', :action => 'update_order'
  map.resources :products do |product|
    product.resources :variations
  end
  map.product_remove_category '/products/:product_id/remove/category/:category_id', :controller => 'products', :action => 'remove_category'
  map.product_add_category    '/products/:product_id/add/category/:category_id', :controller => 'products', :action => 'add_category'
  map.product_toggle_featured '/products/:product_id/toggle_featured', :controller => 'products', :action => 'toggle_featured'
  map.product_toggle_availability '/products/:product_id/toggle_availability', :controller => 'products', :action => 'toggle_availability'
  map.product_variation_toggle_availability '/products/:product_id/variations/:variation_id/toggle_availability', :controller => 'variations', :action => 'toggle_availability'
  map.product_search '/products/search/', :controller => 'products', :action => 'search' 
  map.resources :categories do |category|
    category.resources :products
  end

  map.resource  :session
  map.resources :brands
  map.resources :colors
  map.resources :garment_sizes
  map.resources :orders
  
  map.remove_order_line_item '/orders/:order_id/remove_item/:id', :controller => 'orders', :action => 'remove_item'
  map.edit_order_line_item '/orders/:order_id/edit_item/:id', :controller => 'orders', :action => 'edit_item'
  map.update_order_line_item '/orders/:order_id/update_item/:id', :controller => 'orders', :action => 'update_item'
  map.cancel_order '/orders/cancel/:id', :controller => 'orders', :action => 'cancel'
  map.capture_order '/orders/capture/:id', :controller => 'orders', :action => 'capture'
  map.ship_order '/orders/ship/:id', :controller => 'orders', :action => 'ship'
  map.search_order '/orders/search/', :controller => 'orders', :action => 'search'
  
  map.logout    '/logout',    :controller => 'sessions',  :action => 'destroy'
  map.login     '/login',     :controller => 'sessions',  :action => 'new'
  map.register  '/register',  :controller => 'users',     :action => 'create'
  map.signup    '/signup',    :controller => 'users',     :action => 'new'
  
  map.resources :users, :member => { :suspend   => :put,
                                     :unsuspend => :put,
                                     :purge     => :delete }
  
  map.edit_site_settings '/site_settings/edit', :controller => 'site_settings', :action => 'edit'
  map.update_site_settings '/site_settings/update', :controller => 'site_settings', :action => 'update'
  map.user_add_role '/user/:user_id/add/role/:role_id', :controller => 'users', :action => 'add_role'
  map.user_remove_role '/user/:user_id/remove/role/:role_id', :controller => 'users', :action => 'remove_role'
  
  map.browse_category '/browse/:method/:category_guid', :controller => 'store', :action => 'category'
  map.browse_item '/browse/:method/:category_guid/:product_guid', :controller => 'store', :action => 'product'
  
  map.add_to_cart '/cart/add/:method/:category_guid/:product_guid', :controller => 'store', :action => 'add_to_cart'
  map.remove_from_cart '/cart/remove/:id', :controller => 'store', :action => 'remove_from_cart'
  map.empty_cart 'cart/empty', :controller => 'store', :action => 'empty_cart'
  map.cart '/cart', :controller => 'store', :action => 'cart'
  map.checkout '/checkout', :controller => 'store', :action => 'checkout'
  map.purchase '/purchase', :controller => 'store', :action => 'purchase'
  map.confirm '/confirm', :controller => 'store', :action => 'confirm'
  map.search '/search', :controller => 'store', :action => 'search'
  
  map.connect "logged_exceptions/:action/:id", :controller => "logged_exceptions"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.connect '/', :controller => 'store', :action => 'index'
  map.connect '*path', :controller => 'store', :action => 'not_found' unless ::ActionController::Base.consider_all_requests_local
end
