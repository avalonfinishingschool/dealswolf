class MemberMailer < ApplicationMailer

	def invite_mail(email, team_name, team_owner)
		@email = email
		@team_name = team_name
		@team_creator = team_owner
		mail :subject => "AlphaDeal - You have been added to #{@team_name} by #{@team_owner}",
			:to => email,
			:from => "support@alphadeal.co",
			:template_name => 'invite'
	end


	def welcome_mail(email, team_name, team_owner)
		@email = email
		@team_name = team_name
		@team_creator = team_creator
	    mail :subject => "AlphaDeal - You have been invited to join #{@team_name} by #{@team_creator}",
	         :to      => email,
	         :from    => "support@alphadeal.co",
	         :template_name => 'welcome'
	end
end