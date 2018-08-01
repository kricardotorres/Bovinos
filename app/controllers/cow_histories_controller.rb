class CowHistoriesController < ApplicationController
  before_action :set_cow_history, only: [:show, :edit, :update, :destroy]

  # GET /cow_histories
  # GET /cow_histories.json
  def index
    @cow_histories = CowHistory.all
  end

  # GET /cow_histories/1
  # GET /cow_histories/1.json
  def show
  end

  # GET /cow_histories/new
  def new
    @cow_history = CowHistory.new
  end

  # GET /cow_histories/1/edit
  def edit
  end

  # POST /cow_histories
  # POST /cow_histories.json
  def create
    @cow_history = CowHistory.new(cow_history_params)

    respond_to do |format|
      if @cow_history.save
        format.html { redirect_to @cow_history, notice: 'Cow history was successfully created.' }
        format.json { render :show, status: :created, location: @cow_history }
      else
        format.html { render :new }
        format.json { render json: @cow_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cow_histories/1
  # PATCH/PUT /cow_histories/1.json
  def update
    respond_to do |format|
      if @cow_history.update(cow_history_params)
        format.html { redirect_to @cow_history, notice: 'Cow history was successfully updated.' }
        format.json { render :show, status: :ok, location: @cow_history }
      else
        format.html { render :edit }
        format.json { render json: @cow_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cow_histories/1
  # DELETE /cow_histories/1.json
  def destroy
    @cow_history.destroy
    respond_to do |format|
      format.html { redirect_to cow_histories_url, notice: 'Cow history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cow_history
      @cow_history = CowHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cow_history_params
      params.require(:cow_history).permit(:x, :y, :z)
    end
end
