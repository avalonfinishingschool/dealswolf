class Team < ApplicationRecord
  validates_presence_of :organization, :name, :plan_id, :currency_id
  has_and_belongs_to_many :users, :join_table => :users_teams
  belongs_to :creator, class_name: "User", foreign_key: :user_id, optional:true
  attr_accessor :paypal_payment_token
  extend FriendlyId
  friendly_id :name, use: :slugged
  belongs_to :plan, optional:true
  has_many :deals, :dependent => :destroy
  has_many :activities, :dependent => :destroy
  has_many :stages, :dependent => :destroy
  accepts_nested_attributes_for :stages, :reject_if => :all_blank, :allow_destroy => true
  has_many :people, :dependent => :destroy
  has_many :organizations, :dependent => :destroy
  belongs_to :currency
  
  def save_with_paypal_payment
    # ppr = PayPal::Recurring.new(
    #   token: paypal_payment_token,
    #   payer_id: paypal_customer_token,
    #   description: plan.name+" Plan - AlphaDeals Annual Subscription.",
    #   amount: plan.price.to_s+"0",
    #   currency: "USD"
    # )
    # response = ppr.request_payment
    # raise response.errors.inspect if response.errors.present?
    # if response.approved?
    pp = PayPal::Recurring.new({
      :amount      => plan.price.to_s+"0",
      :currency    => "USD",
      :description => plan.name+" Plan - AlphaDeals Annual Subscription.",
      :frequency   => 1,
      :token       => paypal_payment_token,
      :period      => :yearly,
      :payer_id    => paypal_customer_token,
      :start_at    => Time.zone.now,
      :outstanding     => :next_billing,
      :trial_length    => 7,
      :trial_period    => :daily,
      :trial_frequency => 1
    })

    res = pp.create_recurring_profile
    self.paypal_recurring_profile_token = res.profile_id
    self.renewal_date = DateTime.now + 7.days + 1.year
    save!
    # else

    # end
  end

  def suspend_payment
    ppr = PayPal::Recurring.new(:profile_id => paypal_recurring_profile_token)
    ppr.cancel
  end

end
