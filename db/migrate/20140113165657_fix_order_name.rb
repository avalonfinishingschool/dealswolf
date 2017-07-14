class FixOrderName < ActiveRecord::Migration[5.0]

  	  def change
    rename_column :stages, :order, :ord
  end

end
