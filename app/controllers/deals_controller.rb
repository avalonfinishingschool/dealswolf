class DealsController < ApplicationController
  before_action :set_team
  before_action :set_deal, :except => [:index, :create, :new, :archive, :unarchive, :status]
  before_action :authenticate_user!
  before_action :is_subscription_active
  before_action :is_this_a_team_i_belong_to_or_own?
  before_action :should_modal_be_open
  before_action :is_this_deal_visible_to_me, :except => [:index, :create, :new, :archive, :unarchive, :status]
  require 'date'
  # GET /deals
  # GET /deals.json
  def index
    @deal = Deal.new(:team_id => @team.id)
    # Only visible deals should go into deals_by_month on the whole maybe we should only load visible deals
    #@deals_by_month = show_visible(@deals).sort_by(&:created_at).reverse.group_by { |deal| deal.created_at.strftime("%B '%g") }
    render action: 'all' if params[:view_mode] == "all"
  end

  def status
    @deal = @team.deals.find(params[:deal_id])
    @deal.status = params[:status]
    @deal.save
    redirect_to team_deals_path(@team)
  end

  def archive
    @deal = @team.deals.find(params[:deal_id])
    @deal.archived = true
    @deal.save
    redirect_to team_deals_path(@team)
  end

  def unarchive
    @deal = @team.deals.find(params[:deal_id])
    @deal.archived = false
    @deal.save
    redirect_to team_deals_path(@team)
  end

  def all
    @deals = @team.deals.where(archived: false)
    @deal = Deal.new(:team_id => @team.id)
  end

  # GET /deals/1
  # GET /deals/1.json
  def show
  end

  # GET /deals/new
  def new
    @deal = Deal.new(:team_id => @team.id)
  end

  # GET /deals/1/edit
  def edit
    iwantmodal
    should_modal_be_open
    render :index
  end

  # POST /deals
  # POST /deals.json
  def create
    @deal = Deal.new(deal_params)
    @deal.team = @team
    @deal.user_id = current_user.id

    respond_to do |format|
      if @deal.save
        format.html { redirect_to team_deals_path(@team), notice: 'Deal was successfully created.' }
        format.json { render action: 'show', status: :created, location: @deal }
      else
        @deals = @team.deals
        iwantmodal
        should_modal_be_open
        format.html { render action: 'index' }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deals/1
  # PATCH/PUT /deals/1.json
  def update
    respond_to do |format|
      if @deal.update_attributes(deal_params)
        format.html { redirect_to team_deals_path(@team), notice: 'Deal was successfully updated.' }
        format.json { head :no_content }
        format.js { render layout: false }
      else
        format.html { render action: 'edit' }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
        format.js { render layout: false }
      end
    end
  end

  # DELETE /deals/1
  # DELETE /deals/1.json
  def destroy
    @deal.destroy
    respond_to do |format|
      format.html { redirect_to team_deals_url(@team) }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_team
    @team = Team.friendly.find(params[:team_id])
  end

  def set_deal
    @deal = @team.deals.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def deal_params
    params.require(:deal).permit(:person_id, :organization_id, :title, :value, :close_date, :start_date, :status, :phone, :visibility_id, :archived, :email, :stage_id)
  end
end
