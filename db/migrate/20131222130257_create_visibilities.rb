class CreateVisibilities < ActiveRecord::Migration[5.0]
  def change
    create_table :visibilities do |t|
      t.string :name

      t.timestamps
    end
  end
end
