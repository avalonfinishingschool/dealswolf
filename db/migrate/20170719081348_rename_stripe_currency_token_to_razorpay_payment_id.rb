class RenameStripeCurrencyTokenToRazorpayPaymentId < ActiveRecord::Migration[5.0]
  def change
    rename_column :teams, :stripe_customer_token, :razorpay_payment_id
  end
end
