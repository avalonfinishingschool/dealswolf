class AddRenewalDateToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :renewal_date, :datetime
  end
end
