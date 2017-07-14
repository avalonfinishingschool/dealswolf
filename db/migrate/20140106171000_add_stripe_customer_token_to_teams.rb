class AddStripeCustomerTokenToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :stripe_customer_token, :string
  end
end
