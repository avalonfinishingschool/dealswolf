class AddOrderToStages < ActiveRecord::Migration[5.0]
  def change
    add_column :stages, :order, :integer
  end
end
