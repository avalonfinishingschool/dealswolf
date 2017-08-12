class AddOrganizationToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :organization, :string
  end
end
