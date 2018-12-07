class CarnetsController < ApplicationController
  before_action :set_carnet, only: [:show, :edit, :update, :destroy]

  # GET /carnets
  # GET /carnets.json
  def index
    @carnets = Carnet.all
  end

  # GET /carnets/1
  # GET /carnets/1.json
  def show
  end

  # GET /carnets/new
  def new
    @carnet = Carnet.new
  end

  # GET /carnets/1/edit
  def edit
  end

  # POST /carnets
  # POST /carnets.json
  def create
    @carnet = Carnet.new(carnet_params)

    respond_to do |format|
      if @carnet.save
        format.html { redirect_to @carnet, notice: 'Carnet was successfully created.' }
        format.json { render :show, status: :created, location: @carnet }
      else
        format.html { render :new }
        format.json { render json: @carnet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carnets/1
  # PATCH/PUT /carnets/1.json
  def update
    respond_to do |format|
      if @carnet.update(carnet_params)
        format.html { redirect_to @carnet, notice: 'Carnet was successfully updated.' }
        format.json { render :show, status: :ok, location: @carnet }
      else
        format.html { render :edit }
        format.json { render json: @carnet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carnets/1
  # DELETE /carnets/1.json
  def destroy
    @carnet.destroy
    respond_to do |format|
      format.html { redirect_to carnets_url, notice: 'Carnet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carnet
      @carnet = Carnet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def carnet_params
      params.require(:carnet).permit(:earing_sup, :earing_inf, :vacune, :aplication_date, :weight, :cow_id)
    end
end
