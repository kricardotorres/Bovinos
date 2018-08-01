class Api::CowsController < ApplicationController
 before_action :set_cow, only: [:show, :edit, :update, :destroy]
   skip_before_action :verify_authenticity_token
  def index
    @cows = Cow.all
    render json: @cows
  end
 
  def show
  end
 
  def create
    @cow = Cow.new(cow_params)
 
    if @cow.save
      render json: @cow, status: :created
    else
      render json: @cow.errors, status: :unprocessable_entity
    end
  end
 
  def update
    if @cow.update(cow_params)
      render json: @cow, status: :ok
    else
      render json: @cow.errors, status: :unprocessable_entity
    end
  end
 
  def destroy
    @cow.destroy
    head :no_content
  end
 
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cow
      @cow = Cow.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cow_params
      params.require(:cow).permit(:key_id, :name, :birthday, :deaddate, :deleted_at)
    end
end
