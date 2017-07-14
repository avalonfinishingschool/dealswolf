class CreateDeals < ActiveRecord::Migration[5.0]
  def change
    create_table :deals do |t|
      t.string :contact_name
      t.string :company
      t.string :title
      t.integer :value
      t.integer :currency_id
      t.datetime :close_date
      t.datetime :start_date
      t.string :status
      t.string :phone
      t.integer :visibility_id
      t.string :email
      t.integer :user_id
      t.integer :team_id
      t.integer :stage_id

      t.timestamps
    end
  end
end
