class MyDevise::RegistrationsController < Devise::RegistrationsController

	def create
		super
		if resource.save
			PendingInvitations.search(email: resource.email).each do |p|
				@team = Team.find(p.team_id)
				if @team.users.count + 2 <= @team.plan.number_users
					@team.users << resource
				end
				p.destroy
				# TODO create temp list of members that can be added if one is deleted
			end
		end
	end
end

