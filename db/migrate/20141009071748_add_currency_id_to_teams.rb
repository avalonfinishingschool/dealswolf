class AddCurrencyIdToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :currency_id, :integer
  end
end
