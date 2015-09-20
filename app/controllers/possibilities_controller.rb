class PossibilitiesController < ApplicationController
  before_action :set_possibility, only: [:show, :edit, :update, :destroy]
  before_action :require_current_user, only: [:create, :update, :destroy]

  # GET /possibilities
  # GET /possibilities.json
  def index
    topic_id = params[:topic_id]
    @possibilities = Possibility.where(:topic_id => topic_id)
    @topic = Topic.find topic_id
    respond_to do |format|
      format.html
      format.csv { send_data @possibilities.to_csv }
    end
  end

  # post a vote
  def do_vote
    winner = Possibility.find(params[:winner])
    loser = Possibility.find(params[:loser])
    winner.won = winner.won.nil? ? 1 : winner.won + 1
    loser.lost = loser.lost.nil? ? 1 : loser.lost + 1
    if winner.save! and loser.save!
      redirect_to topic_vote_path
    else
      vote
      render :vote
    end
  end

  def vote
    topic_id = params[:topic_id]
    @possibilities = Possibility.where(:topic_id => topic_id).order("RANDOM()").limit(2)
    if @possibilities.size != 2
      redirect_to topic_possibilities_path topic_id, :alert => 'There are not enough possibilities to start a vote'
    end
    @topic = Topic.find topic_id
  end

  # GET /possibilities/1
  # GET /possibilities/1.json
  def show
    @topic = Topic.find params[:topic_id]
  end

  # GET /possibilities/new
  def new
    @possibility = Possibility.new
    @topic = Topic.find params[:topic_id]
  end

  # GET /possibilities/1/edit
  def edit
    @topic = Topic.find params[:topic_id]
  end

  # POST /possibilities
  # POST /possibilities.json
  def create
    @possibility = Possibility.new(possibility_params)

    respond_to do |format|
      if @possibility.save
        @topic = @possibility.topic
        format.html { redirect_to topic_possibility_path(@possibility.topic_id, @possibility), notice: 'Possibility was successfully created.' }
        format.json { render :show, status: :created, location: @possibility }
      else
        format.html { render :new }
        format.json { render json: @possibility.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /possibilities/1
  # PATCH/PUT /possibilities/1.json
  def update
    respond_to do |format|
      if @possibility.update(possibility_params)
        format.html { redirect_to topic_possibility_path(@possibility.topic_id, @possibility), notice: 'Possibility was successfully updated.' }
        format.json { render :show, status: :ok, location: @possibility }
      else
        format.html { render :edit }
        format.json { render json: @possibility.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /possibilities/1
  # DELETE /possibilities/1.json
  def destroy
    @possibility.destroy
    respond_to do |format|
      format.html { redirect_to topic_possibilities_url, notice: 'Possibility was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def require_current_user
      unless current_user == Topic.find(params[:topic_id]).user or current_user.role == 'admin'
        flash[:error] = "You must have created this topic to access this section"
        redirect_to topic_possibilities_path # halts request cycle
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_possibility
      @possibility = Possibility.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def possibility_params
      params[:possibility][:user_id] = current_user.id
      params[:possibility][:topic_id] = params[:topic_id]
      params.require(:possibility).permit(:name, :user_id, :topic_id)
    end
end
