class AlimentsController < ApplicationController
  before_action :set_aliment, only: [:show, :edit, :update, :destroy]

  # GET /aliments
  # GET /aliments.json
  def index
    @aliments = Aliment.all
  end

  # GET /aliments/1
  # GET /aliments/1.json
  def show
  end

  # GET /aliments/new
  def new
    @aliment = Aliment.new
  end

  # GET /aliments/1/edit
  def edit
  end

  # POST /aliments
  # POST /aliments.json
  def create
    @aliment = Aliment.new(aliment_params)

    respond_to do |format|
      if @aliment.save
        format.html { redirect_to @aliment, notice: 'Aliment was successfully created.' }
        format.json { render :show, status: :created, location: @aliment }
      else
        format.html { render :new }
        format.json { render json: @aliment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /aliments/1
  # PATCH/PUT /aliments/1.json
  def update
    respond_to do |format|
      if @aliment.update(aliment_params)
        format.html { redirect_to @aliment, notice: 'Aliment was successfully updated.' }
        format.json { render :show, status: :ok, location: @aliment }
      else
        format.html { render :edit }
        format.json { render json: @aliment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aliments/1
  # DELETE /aliments/1.json
  def destroy
    @aliment.destroy
    respond_to do |format|
      format.html { redirect_to aliments_url, notice: 'Aliment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aliment
      @aliment = Aliment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def aliment_params
      params.require(:aliment).permit(:name)
    end
end
