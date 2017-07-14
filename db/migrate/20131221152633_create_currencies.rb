class CreateCurrencies < ActiveRecord::Migration[5.0]
  def change
    create_table :currencies do |t|
      t.string :country
      t.string :extension

      t.timestamps
    end
  end
end
