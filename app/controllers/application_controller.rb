require 'date'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  layout :layout_by_resource

  def layout_by_resource
    if devise_controller? && resource_name == :user && action_name == 'edit'
      "app-small-nav"
    elsif devise_controller? && resource_name == :user
      "homepages"
    else
      "application"
    end
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :password_confirmation, :current_password, :notif])
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      teams_path
    else
      super
    end
  end

  def is_this_deal_visible_to_me
    unless(@deal.visibility_id == 1 || (@deal.visibility_id == 2 && @deal.user_id == current_user.id))
      redirect_to team_deals_path(@team), :notice => "Unauthorized request."
    end
  end

  def is_subscription_active
    session[:sub_session] == 1
    if params[:team_id]
      @team = Team.friendly.find(params[:team_id])
    else
      @team = Team.friendly.find(params[:id])
    end
    if(DateTime.now > @team.renewal_date)
        redirect_to payment_team_path(@team), :notice => "Your subscription has ended. Please pay to continue"
    end
  end

  def is_this_person_visible_to_me
    unless(@person.visibility_id == 1 || (@person.visibility_id == 2 && @person.user_id == current_user.id))
      redirect_to team_people_path(@team), :notice => "Unauthorized request."
    end
  end

  def is_this_organization_visible_to_me
    unless(@organization.visibility_id == 1 || (@organization.visibility_id == 2 && @organization.user_id == current_user.id))
      redirect_to team_organizations_path(@team), :notice => "Unauthorized request."
    end
  end

  def is_this_activity_visible_to_me
    if @activity.deal
      unless(@activity.deal.visibility_id == 1 || (@activity.deal.visibility_id == 2 && @activity.deal.user_id == current_user.id))
        redirect_to team_deals_path(@team), :notice => "Unauthorized request."
      end
    end
  end

  def show_visible_unarchived_deals(stage)
    (stage.deals.where(:visibility_id =>1).where(archived:false).includes(:currency) + stage.deals.where(:visibility_id =>2).where(archived:false).where(:user_id => current_user.id).includes(:currency))
  end

  def show_visible_deals(stage)
    (stage.deals.where(:visibility_id =>1).includes(:currency) + stage.deals.where(:visibility_id =>2).where(:user_id => current_user.id).includes(:currency))
  end


  def show_visible(deals)
    (deals.where(:visibility_id =>1).includes(:currency) + deals.where(:visibility_id =>2).where(:user_id => current_user.id).includes(:currency))
  end

  def form_deals
    @team.deals.where(:visibility_id => 1) + @team.deals.where(:visibility_id => 2).where(:user_id => current_user.id)
  end

  def form_deals_searched(s)
    @team.deals.where(:visibility_id => 1).basic_search(s) + @team.deals.where(:visibility_id => 2).where(:user_id => current_user.id).basic_search(s)
  end

  def form_people
    @team.people.where(:visibility_id => 1) + @team.people.where(:visibility_id => 2).where(:user_id => current_user.id)
  end


  def form_people_searched(s)
    @team.people.where(:visibility_id => 1).basic_search(s) + @team.people.where(:visibility_id => 2).where(:user_id => current_user.id).basic_search(s)
  end


  def form_organizations
    @team.organizations.where(:visibility_id => 1) + @team.organizations.where(:visibility_id => 2).where(:user_id => current_user.id)
  end


  def form_organizations_searched(s)
    @team.organizations.where(:visibility_id => 1).basic_search(s) + @team.organizations.where(:visibility_id => 2).where(:user_id => current_user.id).basic_search(s)
  end
  def is_owner?
    if @team.creator == current_user
    else
      redirect_to teams_path, :notice => "Unauthorized request."
    end

  end

  def is_this_a_team_i_belong_to_or_own?
    if @team.creator == current_user || current_user.teams.include?(@team)
      #we're good
    else
      redirect_to teams_path, :notice => "Unauthorized request."
    end
  end


  def has_expired_or_limit?
    #(@team.renewal_date + @team.plan.duration.months) - Time.now  >= 0)  && (
    if @team.users.count + 2 <= @team.plan.number_users
      false
    else
      true
    end
  end

  def should_modal_be_open
    if session[:modal] == true
      @modal = true
    else
      @modal = false
    end
    session[:modal] = false
  end

  def iwantmodal
    session[:modal] = true if session[:modal] == false
  end

  def total_deal_value deals
    value = Hash.new
    sum_pending = 0
    sum_won = 0
    sum_lost = 0
    deals.each do |deal|
      sum_pending+=deal.value if deal.status == "Pending"
      sum_won+=deal.value if deal.status == "Won"
      sum_lost+=deal.value if deal.status == "Lost"
    end
    value["won"] = sum_won
    value["lost"] = sum_lost
    value["pending"] = sum_pending
    return value
  end

  helper_method :total_deal_value, :is_this_a_team_i_belong_to_or_own?, :is_owner?, :show_visible_deals, :show_visible_unarchived_deals, :show_visible, :has_expired_or_limit?, :should_modal_be_open, :iwantmodal, :is_this_deal_visible_to_me, :is_this_activity_visible_to_me, :form_deals, :form_organizations, :form_people

end
