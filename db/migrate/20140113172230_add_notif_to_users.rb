class AddNotifToUsers < ActiveRecord::Migration
  def change
    add_column :users, :notif, :boolean
  end
end
