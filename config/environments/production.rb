# Settings specified here will take precedence over those in config/environment.rb

config.cache_classes = true

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true
config.action_view.cache_template_loading            = true

config.after_initialize do
  ActiveMerchant::Billing::Base.mode = :production
end

config.to_prepare do
  OrderTransaction.gateway = 
    ActiveMerchant::Billing::PaypalGateway.new(
      :login    => 'cactussportsasu_api1.gmail.com',
      :password => 'FGQJQSQX8YF82BEL',
      :signature => 'ALP6VdoB-Xgp8Ii3v8C68Tc8xt3BAqSQTqPrvCLoKbou5PVkCE2FfFos'
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