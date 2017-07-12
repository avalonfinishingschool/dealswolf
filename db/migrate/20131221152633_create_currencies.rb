class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :country
      t.string :extension

      t.timestamps
    end
  end
end
