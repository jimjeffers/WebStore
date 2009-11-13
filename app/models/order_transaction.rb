class OrderTransaction < ActiveRecord::Base
  # Relationships
  belongs_to :order
  
  # Serializations
  serialize :params
  
  # Accessors
  cattr_accessor :gateway
 
  class << self
    def authorize(amount, credit_card, options = {})
      process('authorization', amount) do |gw|
        gw.authorize(amount, credit_card, options)
      end
    end
    
    def capture(amount, authorization, options = {})
      process('capture', amount) do |gw|
        gw.capture(amount, authorization, options)
      end
    end
    
    private
    
    def process(action, amount = nil)
      result = OrderTransaction.new
      result.amount = amount
      result.action = action
    
      begin
        response = yield gateway
        
        result.success   = response.success?
        result.reference = response.authorization
        result.message   = response.message
        result.params    = response.params
        result.test      = response.test?
      rescue ActiveMerchant::ActiveMerchantError => e
        result.success   = false
        result.reference = nil
        result.message   = e.message
        result.params    = {}
        result.test      = gateway.test?
      end
      
      result
    end
  end
end