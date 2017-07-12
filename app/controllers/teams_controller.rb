require 'razorpay'
require 'date'

class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: [:stats, :settings, :show, :edit, :update, :destroy, :deals, :invite, :add_member, :remove, :upgrade, :change_card, :card_edit, :stages, :export_deals, :export_activities, :export_people, :export_organizations, :export, :search, :eagleview]
  before_action :is_subscription_active, except: [:index, :new, :create, :settings, :change_card, :card_edit, :stages, :export_deals, :export_activities, :export_people, :export_organizations, :export, :search, :eagleview, :payment, :destroy]
  #before_action :is_subscription_active, only: [:show]
  skip_before_action :verify_authenticity_token, only: [:payment, :create, :new]
  before_action :set_gon, except: [:index, :new, :create, :payment]
  before_action :is_this_a_team_i_belong_to_or_own?, except: [:index, :new, :create, :payment]
  before_action :is_owner?, only: [:settings, :edit, :update, :destroy, :add_member, :remove, :upgrade, :change_card, :card_edit, :stages, :export_deals, :export_activities, :export_people, :export_organizations, :export, :eagleview]
  

  # GET /teams
  # GET /teams.json
  def index
    render :layout => "app-small-nav"
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    redirect_to team_deals_url(@team)
  end


  def eagleview
    @members = @team.users
    gon.won = @team.deals.where(:status => "Won").count
    gon.lost = @team.deals.where(:status => "Lost").count
    gon.pending = @team.deals.where(:status => "Pending").count
  end

  def search
    @deals_search = form_deals_searched params[:search]
    @or_search = form_organizations_searched params[:search]
    @people_search = form_people_searched params[:search]
    respond_to do |format|
      format.js { render 'layouts/application', :layout => false }
    end
  end

  def export
  end

  def export_deals
    respond_to do |format|
      format.csv { send_data @team.deals.to_csv, filename: "deals-#{Date.today}.csv" }
    end
  end

  def export_people
  respond_to do |format|
      format.csv { send_data @team.people.to_csv, filename: "people-#{Date.today}.csv" }
    end
  end

  def export_organizations
   respond_to do |format|
      format.csv { send_data @team.organizations.to_csv, filename: "organizations-#{Date.today}.csv" }
    end
  end

  def export_activities
    respond_to do |format|
      format.csv { send_data @team.activities.to_csv, filename: "activities-#{Date.today}.csv" }
    end
  end


  # TODO This can be cleaned up if we implement some client side validations
  def stats
    if params[:time_start].nil?
      @deals = @team.deals
      @activities = @team.activities
      @people = @team.people
      @organizations = @team.organizations
    else
      if !params[:time_start].blank? && !params[:time_end].blank?
        if Date.strptime(params[:time_start], '%m/%d/%y') < Date.strptime(params[:time_end], '%m/%d/%y')
          @deals = @team.deals.where(:created_at => params[:time_start]..params[:time_end])
          @activities = @team.activities.where(:created_at => params[:time_start]..params[:time_end])
          @people = @team.people.where(:created_at => params[:time_start]..params[:time_end])
          @organizations = @team.organizations.where(:created_at => params[:time_start]..params[:time_end])
        else
          flash[:notice] = "End date shouldn't be before start date"
          @deals = @team.deals
          @activities = @team.activities
          @people = @team.people
          @organizations = @team.organizations
        end
      elsif !params[:time_start].blank? && params[:time_end].blank?
        @deals = @team.deals.where(:created_at => params[:time_start]..Time.now.strftime("%m/%d/%Y"))
        @activities = @team.activities.where(:created_at => params[:time_start]..Time.now.strftime("%m/%d/%Y"))
        @people = @team.people.where(:created_at => params[:time_start]..Time.now.strftime("%m/%d/%Y"))
        @organizations = @team.organizations.where(:created_at => params[:time_start]..Time.now.strftime("%m/%d/%Y"))
      else
        flash[:notice] = "Error in time format"
        @deals = @team.deals
        @activities = @team.activities
        @people = @team.people
        @organizations = @team.organizations
      end
    end

    gon.deals = @deals
    gon.activities = @activities
    gon.people = @people
    gon.organizations = @organizations
  end

  def remove
    usr = User.find(params[:user_id])
    if @team.users.include?(usr)
      @team.users.delete(usr)
      flash[:notice] = "Successfuly removed user from group."
      redirect_to invite_team_path
    else
      flash[:notice] = "Unauthorized Request."
      redirect_to invite_team_path
    end
  end

  def invite
    @members = @team.users
    @pending_invites = PendingInvitations.search(team_id: @team.id)
  end

  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to request.referer, notice: 'Done.' }
        format.json { head :no_content }
      else
        format.html { redirect_to request.referer, flash: "Error." }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_member
    #TODO: Add based on plan! And test expires in ffs!
    if has_expired_or_limit?
      flash[:notice] =  "Exceeded plan limit."
      redirect_to teams_path and return
    end


    if params[:add]
      found_user = User.search((params[:add]).to_s.downcase)
      if found_user
        #user found, check if he already belongs
        if (@team.users.include?(found_user)) || (found_user == current_user)
          flash[:notice] = "That user is already a part of this team."
          redirect_to invite_team_path and return
        else
          @team.users << found_user
          MemberMailer.welcome_mail(found_user.email).deliver
          flash[:notice] = "Successfully added #{found_user.email}."
          redirect_to invite_team_path and return
        end
      else
        #Send this email-id an email invite to join dreamdeal.
        email = (params[:add]).to_s.downcase
        p = PendingInvitations.search(team_id: @team.id, email: email)
        if p.length > 0
          flash[:notice] = "An invitation has been sent to #{p.first.email}"
          MemberMailer.invite_mail(email, @team.name, @team.creator.email).deliver
          redirect_to invite_team_path and return
        elsif p.length == 0
          new_invite = PendingInvitations.new(team_id: @team.id, email: email)
          if new_invite.save
            MemberMailer.invite_mail(email, @team.name, @team.creator.email).deliver
            flash[:notice] = "No such user found on AlphaDeal. An invitation has been sent."
            redirect_to invite_team_path and return
          else
            flash[:notice] = "An invitation could not be sent at this time. Please try later."
            redirect_to invite_team_path and return
          end
        end
      end
    end
  end

  # GET /teams/new
  def new
    unless current_user.owned_team
      @team = Team.new
      @team.creator = current_user
      render :layout => "app-small-nav"
    else
      redirect_to root_path, notice: "You already own a team!"
    end
  end

  def change_card
  end

  def card_edit
    c = Stripe::Customer.retrieve(@team.stripe_customer_token)
    old_card = c.cards.all.first.id
    c.cards.create(:card => params[:team][:stripe_card_token])
    c.cards.retrieve(old_card).delete()
    redirect_to change_card_team_path, notice: "Card changed"
  end

  def upgrade
    #if params[:team][:plan_id] == @team.plan
    #flash[:notice] = "You're already on this plan."
    #redirect_to settings_team_path(@team) and return
    #end

    unless params[:team][:plan_id].to_i <= @team.plan.id && Plan.find(params[:team][:plan_id]).number_users <= @team.users.count
      c = Stripe::Customer.retrieve(@team.stripe_customer_token)
      c.update_subscription(:plan => params[:team][:plan_id], :prorate => true)
      @team.plan_id = params[:team][:plan_id]
      @team.save!
      flash[:notice] = "Successfully changed plan."
      redirect_to settings_team_path(@team)
    else
      flash[:notice] = "You have selected a plan that allows for only #{Plan.find(params[:team][:plan_id]).number_users} users. Remove some users from the members tab before you downgrade."
      redirect_to settings_team_path(@team) and return
    end
  end

  def settings
  end
  # POST /teams
  # POST /teams.json
  def create
    response = Razorpay::Payment.fetch(params[:razorpay_payment_id]).capture({amount:100})
    #--------------------------------------------------------------------------
    @team = Team.new(team_params)
    @team.creator = current_user
    @team.razorpay_payment_id = params[:razorpay_payment_id]
    @team.renewal_date = DateTime.now + 1.year

    respond_to do |format|
      if @team.save

        @team.stages.create(:name => "Initial")
        @team.stages.create(:name => "Contact Made")
        @team.stages.create(:name => "Negotiation")
        @team.stages.create(:name => "Close to Clinch")

        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render action: 'show', status: :created, location: @team }

      else

        flash[:notice] = @team.errors.full_messages.join(' ')
        format.html { render layout: 'app-small-nav', action: 'new'}
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def payment
    if request.post?
      @team = Team.friendly.find(params[:team_id])
      @team.razorpay_payment_id = params[:razorpay_payment_id]
      Razorpay::Payment.fetch(params[:razorpay_payment_id]).capture({amount:100})
      @team.renewal_date = DateTime.now
      @team.save
      redirect_to @team, notice:"Subcription successfully renewed"
    else
      @team = Team.friendly.find(params[:team_id])
    end
  end
  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy


    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end

  def stages

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_team
    if params[:team_id]
      @team = Team.friendly.find(params[:team_id])
    else
      @team = Team.friendly.find(params[:id])
    end
  end

  def set_gon
    gon.deals = @team.deals
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def team_params
    params.require(:team).permit(:name, :currency_id, :plan_id, :razorpay_payment_id,:renewal_date, :card_number, :card_month, :card_code,stages_attributes: [:id, :name, :ord, :_destroy])
  end
end
