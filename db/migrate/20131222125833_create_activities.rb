class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.string :name
      t.integer :deal_id
      t.integer :team_id
      t.integer :contact_id
      t.integer :organization_id
      t.integer :type_id
      t.string :note
      t.datetime :date
      t.datetime :time
      t.integer :length
      t.integer :user_id
      t.boolean :done

      t.timestamps
    end
  end
end
