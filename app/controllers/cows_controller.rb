class CowsController < ApplicationController
  before_action :set_cow, only: [:show, :edit, :update, :destroy]

    def index
    search
  end
  
  # GET /cows/1
  # GET /cows/1.json
  def show
    @cow = Cow.find(params[:id])

  end

  # GET /cows/new
  def new
    @cow = Cow.new  
    respond_to do |format| 
      format.js if request.xhr?
      format.html { redirect_to :action => "index"}
    end
  end
  def delete
    @cow = Cow.find(params[:cow_id])
  end
  # GET /cows/1/edit
  def edit
  end

  # POST /cows
  # POST /cows.json
  def create
    

    @cow = Cow.new(cow_params) 
    @cow.save
    search
  end

  # PATCH/PUT /cows/1
  # PATCH/PUT /cows/1.json
  def update
   respond_to do |format|
    if @cow.update(cow_params)
      search
      format.html { redirect_to @cow, notice: 'cow was successfully updated.' }
      format.json { render :show, status: :ok, location: @cow }
      format.js
    else
      format.html { render :edit }
      format.json { render json: @cow.errors, status: :unprocessable_entity }
      format.js
    end
  end
end



def destroy 
  @cow.destroy
  respond_to do |format|
    format.html { redirect_to cows_url, notice: 'cow was successfully destroyed.' }
    format.json { head :no_content }
  end
end

def search(per_page = 10)
  params[:q] ||= {}
  params[:per_page] = 10
  @q = Cow.ransack(params[:q])
  @cows =  @q.result(distinct: true).page(params[:page]).per(params[:per_page])
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
