# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = false
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = true

# Don't care if the mailer can't send
#config.action_mailer.raise_delivery_errors = false

config.after_initialize do
  ActiveMerchant::Billing::Base.mode = :test
end

config.to_prepare do
  OrderTransaction.gateway = 
    ActiveMerchant::Billing::PaypalGateway.new(
      :login    => 'test_1261052303_biz_api1.sumocreations.com',
      :password => '1261052310',
      :signature => 'A--8MSCLabuvN8L.-MHjxC9uypBtAkqKQ7InO9rWRAV1ThB1O4nmdRk0'
    )
end

ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address        => 'smtp.gmail.com',
  :port           => 587,
  :domain         => 'jimjeffers.com',
  :authentication => :plain,
  :user_name      => 'test@jimjeffers.com',
  :password       => 't3st3r'
}