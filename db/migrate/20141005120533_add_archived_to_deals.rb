class AddArchivedToDeals < ActiveRecord::Migration[5.0]
  def change
    add_column :deals, :archived, :boolean, :default => false
  end
end
