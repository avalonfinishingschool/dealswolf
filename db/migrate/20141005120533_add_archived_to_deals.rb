class AddArchivedToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :archived, :boolean, :default => false
  end
end
