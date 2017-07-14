class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.string :name
      t.string :organization_id
      t.integer :user_id
      t.integer :team_id
      t.integer :visibility_id

      t.timestamps
    end
  end
end
