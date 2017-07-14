class CreatePendingInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :pending_invitations do |t|
      t.integer :team_id
      t.string :email

      t.timestamps
    end
  end
end
