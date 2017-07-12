class ChangeContactIdtoPersonId < ActiveRecord::Migration
  def change
  	remove_column :activities, :contact_id
  	add_column :activities, :person_id, :integer
  end
end