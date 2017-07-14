class DefaultValueForTeamCurrencyId < ActiveRecord::Migration[5.0]
  def change
  	change_column :teams, :currency_id, :integer, :default => 1
  end
end
