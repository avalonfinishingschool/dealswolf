class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.string :name
      t.integer :number_users
      t.integer :duration
      t.integer :price

      t.timestamps
    end
  end
end
