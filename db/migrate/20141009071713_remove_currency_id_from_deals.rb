class RemoveCurrencyIdFromDeals < ActiveRecord::Migration[5.0]
  def change
    remove_column :deals, :currency_id, :integer
  end
end
