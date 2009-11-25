class Order < ActiveRecord::Base
  # Relationships
  has_many :transactions, :class_name => 'OrderTransaction', :dependent => :destroy
  belongs_to :cart
  
  # Validations
  validates_presence_of :email
  validates_presence_of :shipping_first
  validates_presence_of :shipping_last
  validates_presence_of :shipping_1
  validates_presence_of :shipping_city
  validates_presence_of :shipping_state
  validates_presence_of :shipping_zip
  validates_presence_of :billing_first
  validates_presence_of :billing_last
  validates_presence_of :billing_1
  validates_presence_of :billing_city
  validates_presence_of :billing_state
  validates_presence_of :billing_zip
  validates_presence_of :card_number, :if => :ready_for_processing?
  validates_presence_of :verification_number, :if => :ready_for_processing?
  validates_presence_of :expiration_month, :if => :ready_for_processing?
  validates_presence_of :expiration_year, :if => :ready_for_processing?
  
  # Named Scope
  named_scope :currently, lambda { |state| {
      :conditions => ['aasm_state=?',state]
    }
  }
  
  # Accessors
  attr_accessor :verification_number, :card_number, :card_type, :same_as_billing, :expiration_month, :expiration_year, :credit_card, :first_name, :last_name
  
  # AASM States
  include AASM
  aasm_initial_state :pending

  aasm_state :pending
  aasm_state :authorized
  aasm_state :paid
  aasm_state :payment_declined
  aasm_state :shipped
  aasm_state :canceled

  aasm_event :payment_authorized do
    transitions :from => :pending, 
                :to   => :authorized

    transitions :from => :payment_declined, 
                :to   => :authorized
  end

  aasm_event :payment_captured do
    transitions :from => :authorized, 
                :to   => :paid
  end
  
  aasm_event :order_shipped do
    transitions :from => :paid,
                :to => :shipped
  end
  
  aasm_event :order_canceled do
    transitions :from => :paid,
                :to => :canceled
  end
  
  aasm_event :transaction_declined do
    transitions :from => :pending, 
                :to   => :payment_declined

    transitions :from => :payment_declined, 
                :to   => :payment_declined

    transitions :from => :authorized, 
                :to   => :authorized
  end
  
  # Constants
  PREORDER_FIELDS = [ :shipping_first,:shipping_last,:shipping_1,:shipping_2,:shipping_city,:shipping_state,:shipping_zip,
                      :billing_first,:billing_last,:billing_1,:billing_2,:billing_city,:billing_state,:billing_zip,
                      :shipping_method ]
  
  # Boolean test to determine if a given set of attributes are throwing errors on the order.
  def has_problems_with?(attributes)
    unless valid?
      attributes.each do |attribute|
        return true if errors.invalid?(attribute)
      end
    end
    return false
  end
  
  # Only retrieves errors for specified attributes.
  def errors_only_for(attributes)
    valid?
    filtered_errors = []
    errors.each do |error_name, error_message|
      if attributes.include?(error_name.to_sym)
        filtered_errors << [error_name, error_message]
      end
    end
    filtered_errors
    return filtered_errors
  end
  
  # BEGIN authorize_payment
  def authorize_payment(options = {:ip => '127.0.0.1'})
    options = setup_order(options)
    
    transaction do
      authorization = OrderTransaction.authorize(calculate_amount, credit_card, options)
      transactions.push(authorization)

      if authorization.success?
        payment_authorized!
      else
        transaction_declined!
      end

      authorization
    end
  end

  def setup_order(options)
    options[:description] = "CS Order ID: #{id}"
    options[:order_id] = "#{number}"
    options[:billing_address] = {
      :name => "#{billing_first} #{billing_last}",
      :address1 => "#{billing_1}",
      :address2 => "#{billing_2}",
      :city => "#{billing_city}",
      :state => "#{billing_state}",
      :zip => "#{billing_zip}",
      :country => "US"
    }
  
    options[:shipping_address] = {
      :name => "#{shipping_first} #{shipping_last}",
      :address1 => "#{shipping_1}",
      :address2 => "#{shipping_2}",
      :city => "#{shipping_city}",
      :state => "#{shipping_state}",
      :zip => "#{shipping_zip}",
      :country => "US"
    }
    
    #options[:email] = email
    options[:merchant] = "Cactus Sports.com"
    options
  end

  # BEGIN capture_payment
  def capture_payment(options = {:ip => '127.0.0.1'})
    transaction do
      capture = OrderTransaction.capture(amount, authorization_reference, options)
      transactions.push(capture)
      if capture.success?
        payment_captured!
      else
        transaction_declined!
      end
      capture
    end
  end

  # Retrieves the latest uthorization reference stored for the current order.
  def authorization_reference
    if authorization = transactions.find_by_action_and_success('authorization', true, :order => 'id ASC')
      authorization.reference
    end
  end
  
  # Generates a unique order id for the authorization_request.
  def number
    md5 = Digest::MD5.new
    now = Time.now
    md5 << now.to_s
    md5 << String(now.usec)
    md5 << String(rand(0))
    md5 << String($$)
    md5 << "invoice_#{id}"
    md5.hexdigest
  end
  
  # Creates a new active merchant credit card object given stored parameters.
  def credit_card
    credit_card = ActiveMerchant::Billing::CreditCard.new(
      :first_name         => billing_first,
      :last_name          => billing_last,
      :number             => card_number,
      :month              => expiration_month,
      :year               => expiration_year,
      :verification_value => verification_number
    )
  end
  
  # Creates amount recognizeable by payment gateways.
  def calculate_amount
    self.sub_total = (cart.running_total*100).to_i
    if Store::SALES_TAX_STATES.include?(self.billing_state)
      self.sales_tax = (cart.running_total*Store::SALES_TAX_RATE*100).to_i
    else
      self.sales_tax = 0
    end
    self.shipping_cost = (Store::SHIPPING_RATES[self.shipping_method]*100).to_i
    self.amount = self.sub_total + self.sales_tax + self.shipping_cost
  end
  
  # Assigns cart to order and attempts to authorize payment.
  def process_cart(cart)
    self.cart = cart
    cart.authorize! if cart.new?
    self.save
    self.authorize_payment
    if authorized?
      self.capture_payment
      if self.paid?
        @cart.close!
        @cart.line_items.not_deleted.each { |i| i.close! }
        return true
      else
        return false
      end
    else
      return false
    end
  end
  
  # Assigns cart to order and determines sales tax and shipping costs.
  def calculate_cart(cart)
    self.cart = cart
    calculate_amount
  end
  
  def ready_for_processing?
    !self.cart.nil?
  end
end