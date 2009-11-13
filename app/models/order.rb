class Order < ActiveRecord::Base
  # Relationships
  has_many :transactions, :class_name => 'OrderTransaction', :dependent => :destroy
  belongs_to :cart
  
  # Validations
  validates_presence_of :email
  validates_presence_of :shipping_first
  validates_presence_of :shipping_last
  validates_presence_of :shipping_1
  validates_presence_of :shipping_2
  validates_presence_of :shipping_city
  validates_presence_of :shipping_state
  validates_presence_of :shipping_zip
  validates_presence_of :billing_first
  validates_presence_of :billing_last
  validates_presence_of :billing_1
  validates_presence_of :billing_2
  validates_presence_of :billing_city
  validates_presence_of :billing_state
  validates_presence_of :billing_zip
  validates_presence_of :card_number
  validates_presence_of :verification_number
  validates_presence_of :expiration_month
  validates_presence_of :expiration_year
  
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
  
  # BEGIN authorize_payment
  def authorize_payment(options = {:ip => '127.0.0.1'})
    options = setup_order(options)
    
    transaction do
      puts "-"*100+"\n"
      puts "ATTEMPTING TO AUTHORIZE"
      authorization = OrderTransaction.authorize(amount, credit_card, options)
      transactions.push(authorization)

      if authorization.success?
        puts "-"*100+" \n Payment Authorized"
        payment_authorized!
      else
        transaction_declined!
      end

      authorization
    end
  end

  def setup_order(options)
    options[:description] = "USAEnergyGuide Order: #{id}"
    
    options[:order_id] = "#{number}"
    unless billing_address.nil?
      options[:billing_address] = {
        :name => "#{billing_address.first_name} #{billing_address.last_name}",
        :address1 => "#{billing_address.street_1}",
        :address2 => "#{billing_address.street_2}",
        :city => "#{billing_address.city}",
        :state => "#{billing_address.state}",
        :zip => "#{billing_address.zip}",
        :country => "#{billing_address.country}"
      }
    end
    
    unless shipping_address.nil?
      options[:shipping_address] = {
        :name => "#{first_name} #{last_name}",
        :address1 => "#{address_1}",
        :address2 => "#{address_2}",
        :city => "#{city}",
        :state => "#{shipping_state}",
        :zip => "#{zip}"
      }
    end
    
    options[:merchant] = "USAEnergyGuide.com"
    options
    #options[:email] = user.email
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
      :first_name         => first_name,
      :last_name          => last_name,
      :number             => card_number,
      :month              => expiration_month,
      :year               => expiration_year,
      :verification_value => verification_number
    )
  end
  
  def billing_address
    #ProfileAddress.find_with_deleted(read_attribute(:billing_address_id))
    nil
  end
  
  def shipping_address
    #ProfileAddress.find_with_deleted(read_attribute(:shipping_address_id))
    nil
  end
  
  def amount
    (invoice.amount*100).to_i
  end
end