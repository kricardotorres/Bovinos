class Api::CowHistoriesController  < ActionController::Base
 before_action :set_cow_history_history, only: [:show, :edit, :update, :destroy]
  
  def index
    @cow_history_histories = CowHistory.all
    render json: @cow_history_histories
  end
 
  def show
  end
 
  def create
    @cow_history = CowHistory.new(cow_history_params)
    @cow_history.cow_id = 1
    @cow_history.arduino_device_id = 1
    if @cow_history.save
      render json: @cow_history, status: :created
    else
      render json: @cow_history.errors, status: :unprocessable_entity
    end
  end
 
  def update
    if @cow_history.update(cow_history_params)
      render json: @cow_history, status: :ok
    else
      render json: @cow_history.errors, status: :unprocessable_entity
    end
  end
 
  def destroy
    @cow_history.destroy
    head :no_content
  end
 
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cow_history
      @cow_history = CowHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cow_history_params
      params.require(:cow_history).permit(:x, :y, :z, :cow_id, :arduino_device_id)
    end
end
