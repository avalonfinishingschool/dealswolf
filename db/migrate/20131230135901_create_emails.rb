class CreateEmails < ActiveRecord::Migration[5.0]
  def change
    create_table :emails do |t|
      t.integer :person_id
      t.string :value

      t.timestamps
    end
  end
end
