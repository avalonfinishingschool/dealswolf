class DefaultValueForTeamCurrencyId < ActiveRecord::Migration
  def change
  	change_column :teams, :currency_id, :integer, :default => 1
  end
end
