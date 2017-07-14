class AddPersonIdToDeals < ActiveRecord::Migration[5.0]
  def change
    add_column :deals, :person_id, :integer
    add_column :deals, :organization_id, :integer
    remove_column :deals, :contact_name
    remove_column :deals, :company
  end
end
