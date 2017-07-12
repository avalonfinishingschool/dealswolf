class PeopleController < ApplicationController
  before_action :set_team
  before_action :set_person, :except => [:index, :create, :new, :contacts_callback]
  before_action :authenticate_user!
  before_action :is_subscription_active
  before_action :is_this_a_team_i_belong_to_or_own?
  before_action :should_modal_be_open
  before_action :is_this_person_visible_to_me, :except => [:contacts_callback, :index, :create, :new]

  # GET /people
  # GET /people.json
  def index
    @people = @team.people.includes(:organization)
    @person = Person.new(:team_id => @team.id)
  end

  # GET /people/1
  # GET /people/1.json
  def show
  end

 def contacts_callback
 end

  # GET /people/new
  def new
    @person = Person.new(:team_id => @team.id)
    iwantmodal
    should_modal_be_open
    render :index
  end

  # GET /people/1/edit
  def edit
    iwantmodal
    should_modal_be_open
    render :index
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)
    @person.team = @team
    @person.user_id = current_user.id
    respond_to do |format|
      if @person.save
        format.html { redirect_to team_people_path(@team), notice: 'Person was successfully created.' }
        format.json { render action: 'show', status: :created, location: @person }
      else
        @people = @team.people.all
        iwantmodal
        should_modal_be_open
        format.html { render action: 'index' }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to team_people_path(@team), notice: 'Person was successfully updated.' }
        format.json { head :no_content }
      else
        iwantmodal
        should_modal_be_open
        format.html { render action: 'index' }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to team_people_url(@team) }
      format.json { head :no_content }
    end
  end

  private
      def set_team
      @team = Team.friendly.find(params[:team_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:name, :organization_id, :visibility_id, emails_attributes: [:id, :value, :_destroy], phones_attributes: [:id, :number, :_destroy])
    end
end
