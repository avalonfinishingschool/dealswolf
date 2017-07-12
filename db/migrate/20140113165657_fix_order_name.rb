class FixOrderName < ActiveRecord::Migration

  	  def change
    rename_column :stages, :order, :ord
  end

end
