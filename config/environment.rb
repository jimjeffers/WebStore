# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Specify gems that this application depends on and have them installed with rake gems:install
  config.gem "rubyist-aasm", :lib => "aasm", :source => "http://gems.github.com"
  config.gem "inherited_resources", :version => ">= 0.9.2", :source => "http://gemcutter.org"
  config.gem "RedCloth", :lib => 'redcloth', :version => ">= 4.0"
  config.gem "thoughtbot-factory_girl", :lib    => "factory_girl", :source => "http://gems.github.com"
  config.gem "yfactorial-utility_scopes", :lib => "utility_scopes", :source => "http://gems.github.com/"
  config.gem "activemerchant", :lib => "active_merchant", :version => "1.4.2"
  config.gem 'will_paginate', :version => '>= 2.3.11', :source => 'http://gemcutter.org'
  
  # Only load the plugins named here, in the order given (default is alphabetical).
  config.plugins = [ :exception_notification, :all ] # can use :all as a placeholder.

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
  config.active_record.observers = :user_observer
  
  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'
  
  # Setup memcache store.
  config.cache_store = :mem_cache_store, "localhost"
  
  # Add custom load paths for specialized objects outside of the MVC.
  config.load_paths << "#{RAILS_ROOT}/app/sweepers"
end