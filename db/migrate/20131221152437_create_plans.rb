class CreatePlans < ActiveRecord::Migration
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
