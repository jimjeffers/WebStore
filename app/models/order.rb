class Order < ActiveRecord::Base
  # Relationships
  has_many :transactions, :class_name => 'OrderTransaction', :dependent => :destroy
  belongs_to :cart
  
  # Validations
  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_format_of       :email,    :with => /[\w\.%\+\-]+/, :message => 'should be a valid email address.'
  
  validates_presence_of     :shipping_first
  validates_presence_of     :shipping_last
  validates_presence_of     :shipping_1
  validates_presence_of     :shipping_city
  validates_presence_of     :shipping_state
  validates_presence_of     :shipping_zip
  
  validates_presence_of     :billing_first
  validates_presence_of     :billing_last
  validates_presence_of     :billing_1
  validates_presence_of     :billing_city
  validates_presence_of     :billing_state
  validates_presence_of     :billing_zip
  
  validates_presence_of     :phone
  validates_length_of       :phone, :within => 7..15
  
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
  
  # Constants
  ORDER_NUMBER_START = 18438
  
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
    transitions :from => [:authorized,:paid],
                :to => :shipped
  end
  
  aasm_event :order_canceled do
    transitions :from => [:authorized,:paid],
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
  PREORDER_FIELDS = [ :email,:phone,:shipping_first,:shipping_last,:shipping_1,:shipping_2,:shipping_city,:shipping_state,:shipping_zip,
                      :billing_first,:billing_last,:billing_1,:billing_2,:billing_city,:billing_state,:billing_zip,
                      :shipping_method ]
    
  # Searches orders.
  def self.search(term)
    terms = term.split(" ")
    if terms.length > 1
      Order.find(:all, :conditions => ['billing_first LIKE ? AND billing_last LIKE ?',"%#{terms[0]}%","%#{terms[1]}%"])
    else
      if !(term.upcase =~ /CS\-/).nil?
        search_order_id = term.upcase.gsub('CS-','').to_i
        search_order_id += ORDER_NUMBER_START if search_order_id < ORDER_NUMBER_START
        Order.find(:all, :conditions => ['cs_number=?',search_order_id])
      else
        Order.find(:all, :conditions => ['billing_first LIKE ? OR billing_last LIKE ? or id=? or cs_number=?',"%#{term}%","%#{term}%",term,term])
      end
    end
  end
  
  # Sets the cs_number in the database to match the order number.
  def after_save
    update_attribute(:cs_number, ref_number) if cs_number != ref_number
  end
  
  # Calculates the reference number based off the item id.
  def ref_number
    id + ORDER_NUMBER_START
  end
  
  # Boolean test to determine if a given set of attributes are throwing errors on the order.
  def has_problems_with?(attributes)
    unless valid?
      attributes.each do |attribute|
        return true if errors.invalid?(attribute)
      end
    end
    return false
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

  # Retrieves the latest authorization reference stored for the current order.
  def authorization_reference
    if authorization = transactions.find_by_action_and_success('authorization', true, :order => 'id ASC')
      authorization.reference
    end
  end
  
  # Retrieves the capture reference stored for the current order.
  def capture_reference
    if capture = transactions.find_by_action_and_success('capture', true, :order => 'id ASC')
      capture.reference
    end
  end
  
  def refund!(options = {:ip => '127.0.0.1'})
    transaction do
      refund = OrderTransaction.credit(amount, capture_reference)
      transactions.push(refund)
      if refund.success?
        order_canceled!
      end
      refund
    end
  end
  
  def void!(options = {:ip => '127.0.0.1'})
    transaction do
      refund = OrderTransaction.void(amount, capture_reference)
      transactions.push(refund)
      if refund.success?
        order_canceled!
      end
      refund
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
    if Store::SALES_TAX_STATES.include?(self.billing_state) && Store::SALES_TAX_STATES.include?(self.shipping_state)
      self.sales_tax = (cart.running_total*Store::SALES_TAX_RATE*100).to_i
    else
      self.sales_tax = 0
    end
    self.shipping_cost = (Store.calculate_shipping_cost(self.sub_total/100.to_f,self.shipping_method,cart.additional_shipping_total)*100).to_i
    self.amount = self.sub_total + self.sales_tax + self.shipping_cost
  end
  
  # Assigns cart to order and attempts to authorize payment.
  def process_cart(cart)
    self.cart = cart
    cart.authorize! if cart.new?
    self.save
    self.authorize_payment
    if authorized?
      @cart.close!
      @cart.line_items.not_deleted.each { |i| i.close! }
      self.update_attribute(:card_reference, "**** **** **** #{card_number[-4..-1]}") unless card_number.nil?
      return true
    else
      return false
    end
  end
  
  # Assigns cart to order and determines sales tax and shipping costs.
  def calculate_cart(cart)
    self.cart = cart
    calculate_amount
  end
  
  # Determins if order has been assigned to a cart yet.
  def ready_for_processing?
    !self.cart.nil? && self.pending?
  end
  
  # Removes a given line item from an order.
  def remove_line_item(id)
    return false if self.shipped?
    line_item = self.cart.line_items.find(id)
    puts line_item.to_yaml
    line_item.late_destroy
    self.calculate_amount
    self.save
  end
end