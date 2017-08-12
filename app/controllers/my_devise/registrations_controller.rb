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

  def edit
    @team = current_user.owned_team if current_user.owned_team.present?
    render :edit
  end

	def update
		self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      bypass_sign_in resource, scope: resource_name
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      flash[:notice] = "Invalid current password entered."
      redirect_to edit_user_registration_path
    end
	end

	protected

    def after_update_path_for(resource)
      teams_path
    end
end

