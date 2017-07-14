class UsersTeamsJoin < ActiveRecord::Migration[5.0]
  def change
  	create_table 'users_teams', :id => false do |t|
    t.column :user_id, :integer
    t.column :team_id, :integer
  end
  end
end
