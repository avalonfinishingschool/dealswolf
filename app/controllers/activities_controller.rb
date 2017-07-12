class ActivitiesController < ApplicationController
  before_action :set_team
  before_action :set_activity, except: [:index, :create, :new]
  before_action :authenticate_user!
   before_action :is_subscription_active
  before_action :is_this_a_team_i_belong_to_or_own?
  before_action :should_modal_be_open
  before_action :is_this_activity_visible_to_me, :except => [:index, :create, :new]


  # GET /activities
  # GET /activities.json
  def index
    @activities = @team.activities
    @activity = Activity.new(team_id: @team.id)
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
  end

  # GET /activities/new
  def new
    @activity = Activity.new(team_id: @team.id)
    iwantmodal
    should_modal_be_open
    render :index
  end

  # GET /activities/1/edit
  def edit
    iwantmodal
    should_modal_be_open
    render :index
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(activity_params)
    @activity.team = @team

    respond_to do |format|
      if @activity.save
        format.html { redirect_to team_activities_path(@team), notice: 'Activity was successfully created.' }
        format.json { render action: 'show', status: :created, location: @activity }
      else
        @activities = @team.activities
        iwantmodal
        should_modal_be_open
        format.html { render action: 'index' }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to team_activities_path(@team), notice: 'Activity was successfully updated.' }
        format.json { head :no_content }
      else
        iwantmodal
        should_modal_be_open
        format.html { render action: 'index' }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to team_activities_path(@team) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.friendly.find(params[:team_id])
    end

    def set_activity
      @activity = @team.activities.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:name, :deal_id, :team_id, :person_id, :organization_id, :type_id, :note, :date, :time, :length, :user_id, :done)
    end
end
