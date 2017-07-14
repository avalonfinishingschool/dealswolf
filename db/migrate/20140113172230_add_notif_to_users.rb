class AddNotifToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :notif, :boolean
  end
end
