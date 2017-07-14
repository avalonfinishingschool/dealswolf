class ChangeContactIdtoPersonId < ActiveRecord::Migration[5.0]
  def change
  	remove_column :activities, :contact_id
  	add_column :activities, :person_id, :integer
  end
end