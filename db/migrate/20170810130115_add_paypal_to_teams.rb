class AddPaypalToTeams < ActiveRecord::Migration[5.0]
  def change
    remove_column :teams, :razorpay_payment_id
    add_column :teams, :paypal_customer_token, :string
    add_column :teams, :paypal_recurring_profile_token, :string
  end
end
