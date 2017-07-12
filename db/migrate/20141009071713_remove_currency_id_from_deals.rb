class RemoveCurrencyIdFromDeals < ActiveRecord::Migration
  def change
    remove_column :deals, :currency_id, :integer
  end
end
