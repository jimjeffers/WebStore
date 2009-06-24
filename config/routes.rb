ActionController::Routing::Routes.draw do |map|

  map.resources :products do |product|
    product.resources :variations
    product.resources :photos
  end

  map.resources :categories do |category|
    category.resources :products
  end

  map.resource  :session
  map.resources :colors
  map.resources :garment_sizes
  
  map.logout    '/logout',    :controller => 'sessions',  :action => 'destroy'
  map.login     '/login',     :controller => 'sessions',  :action => 'new'
  map.register  '/register',  :controller => 'users',     :action => 'create'
  map.signup    '/signup',    :controller => 'users',     :action => 'new'
  
  map.product_remove_category '/product/:product_id/remove/category/:category_id', :controller => 'products', :action => 'remove_category'
  map.product_add_category    '/product/:product_id/add/category/:category_id', :controller => 'products', :action => 'add_category'
  map.product_search '/product/search/', :controller => 'products', :action => 'search'
  
  map.resources :users, :member => { :suspend   => :put,
                                     :unsuspend => :put,
                                     :purge     => :delete }
                                     
  map.user_add_role '/user/:user_id/add/role/:role_id', :controller => 'users', :action => 'add_role'
  map.user_remove_role '/user/:user_id/remove/role/:role_id', :controller => 'users', :action => 'remove_role'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
