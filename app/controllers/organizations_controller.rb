class OrganizationsController < ApplicationController
  before_action :set_team
  before_action :set_organization, :except => [:index, :create, :new]
  before_action :authenticate_user!
  before_action :is_subscription_active
  before_action :is_this_a_team_i_belong_to_or_own?
  before_action :should_modal_be_open
  before_action :is_this_organization_visible_to_me, :except => [:index, :create, :new]
  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = @team.organizations.all
    @organization = Organization.new(:team_id => @team.id)
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
  end

  # GET /organizations/new
  def new
    @organization = Organization.new(:team_id => @team.id)
    iwantmodal
    should_modal_be_open
    render :index
  end

  # GET /organizations/1/edit
  def edit
    iwantmodal
    should_modal_be_open
    render :index
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)
    @organization.team = @team
    @organization.user_id = current_user.id
    respond_to do |format|
      if @organization.save
        format.html { redirect_to team_organizations_path(@team), notice: 'Organization was successfully created.' }
        format.json { render action: 'show', status: :created, location: @organization }
      else
        @organizations = @team.organizations.all
        iwantmodal
        should_modal_be_open
        format.html { render action: 'index' }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to team_organizations_path(@team), notice: 'Organization was successfully updated.' }
        format.json { head :no_content }
      else
        iwantmodal
        should_modal_be_open
        format.html { render action: 'index' }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to team_organizations_url(@team) }
      format.json { head :no_content }
    end
  end

  private
  def set_team
    @team = Team.friendly.find(params[:team_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_organization
    @organization = Organization.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def organization_params
    params.require(:organization).permit(:name, :address, :visibility_id, :phone)
  end
end
