class AddCurrencyIdToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :currency_id, :integer
  end
end
