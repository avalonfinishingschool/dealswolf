class ChangingColumnTypes < ActiveRecord::Migration
  def change
  	change_column :plans, :price, :decimal
  	remove_column :people, :organization_id
  	add_column :people, :organization_id, :integer
  	remove_column :activities, :time
  end
end
