class PossibilitiesController < ApplicationController
  before_action :set_possibility, only: [:show, :edit, :update, :destroy]

  # GET /possibilities
  # GET /possibilities.json
  def index
    @possibilities = Possibility.all
    @topic = Topic.find params[:topic_id]
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
        format.html { redirect_to @possibility, notice: 'Possibility was successfully updated.' }
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
    # Use callbacks to share common setup or constraints between actions.
    def set_possibility
      @possibility = Possibility.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def possibility_params
      params[:possibility][:user_id] = current_user
      params[:possibility][:topic_id] = params[:topic_id]
      params.require(:possibility).permit(:name, :user_id, :topic_id)
    end
end
