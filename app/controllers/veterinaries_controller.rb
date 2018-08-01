class VeterinariesController < ApplicationController
   
   before_action :set_veterinary, only: [:show, :edit, :update, :destroy]
 # GET /veterinarys
  # GET /veterinarys.json
  def index
    search
  end
  
  # GET /veterinarys/1
  # GET /veterinarys/1.json
  def show
    @veterinary = Veterinary.find(params[:id])

  end

  # GET /veterinarys/new
  def new
    @veterinary = Veterinary.new
    @veterinary.build_user
   
    respond_to do |format|
      #if request.xhr?
       # format.html
      #else
       # format.html { redirect_to customers_url, notice: 'Access denied via url.' }
      #end
      format.js if request.xhr?
      format.html { redirect_to :action => "index"}
    end
  end
  def delete
    @veterinary = Veterinary.find(params[:veterinary_id])
  end
  # GET /veterinarys/1/edit
  def edit
  end

  # POST /veterinarys
  # POST /veterinarys.json
  def create
    search

    @veterinary = Veterinary.new(veterinary_params)
    
    @veterinary.user.role_id = Role.veterinary
    puts Role.veterinary
    puts @veterinary.user.role_id
    @veterinary.save
  end

  # PATCH/PUT /veterinarys/1
  # PATCH/PUT /veterinarys/1.json
  def update
   respond_to do |format|
    if @veterinary.update(veterinary_params)
      search
      format.html { redirect_to @veterinary, notice: 'veterinary was successfully updated.' }
      format.json { render :show, status: :ok, location: @veterinary }
      format.js
    else
      format.html { render :edit }
      format.json { render json: @veterinary.errors, status: :unprocessable_entity }
      format.js
    end
  end
end



def destroy
  user =  User.find(@veterinary.user_id)
  @veterinary.destroy
  user.save!(context: :delete) 
  respond_to do |format|
    format.html { redirect_to veterinaries_url, notice: 'veterinary was successfully destroyed.' }
    format.json { head :no_content }
  end
end

def search(per_page = 10)
  params[:q] ||= {}
  params[:per_page] = 10
  @q = Veterinary.ransack(params[:q])
  @veterinaries =  @q.result(distinct: true).page(params[:page]).per(params[:per_page])
end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_veterinary
      @veterinary = Veterinary.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def veterinary_params
      params.require(:veterinary).permit(:clinic, :phone, :web_site, :address, user_attributes:[ :id, :email, :password, :password_confirmation, :name, :lastname, :role_id])
    end
end 

 