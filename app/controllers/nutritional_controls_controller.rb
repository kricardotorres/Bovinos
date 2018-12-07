class NutritionalControlsController < ApplicationController
  before_action :set_nutritional_control, only: [:show, :edit, :update, :destroy]

  # GET /nutritional_controls
  # GET /nutritional_controls.json
  def index
    @nutritional_controls = NutritionalControl.all
  end

  # GET /nutritional_controls/1
  # GET /nutritional_controls/1.json
  def show
  end

  # GET /nutritional_controls/new
  def new
    @nutritional_control = NutritionalControl.new
  end

  # GET /nutritional_controls/1/edit
  def edit
  end

  # POST /nutritional_controls
  # POST /nutritional_controls.json
  def create
    @nutritional_control = NutritionalControl.new(nutritional_control_params)

    respond_to do |format|
      if @nutritional_control.save
        format.html { redirect_to @nutritional_control, notice: 'Nutritional control was successfully created.' }
        format.json { render :show, status: :created, location: @nutritional_control }
      else
        format.html { render :new }
        format.json { render json: @nutritional_control.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nutritional_controls/1
  # PATCH/PUT /nutritional_controls/1.json
  def update
    respond_to do |format|
      if @nutritional_control.update(nutritional_control_params)
        format.html { redirect_to @nutritional_control, notice: 'Nutritional control was successfully updated.' }
        format.json { render :show, status: :ok, location: @nutritional_control }
      else
        format.html { render :edit }
        format.json { render json: @nutritional_control.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nutritional_controls/1
  # DELETE /nutritional_controls/1.json
  def destroy
    @nutritional_control.destroy
    respond_to do |format|
      format.html { redirect_to nutritional_controls_url, notice: 'Nutritional control was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nutritional_control
      @nutritional_control = NutritionalControl.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nutritional_control_params
      params.require(:nutritional_control).permit(:name, :purpouse, :from_date, :to_date, aliment_ids: [])
    end
end
