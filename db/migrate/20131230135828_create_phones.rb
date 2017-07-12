class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.integer :person_id
      t.string :number

      t.timestamps
    end
  end
end
