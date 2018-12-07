class Admin::UsersController < ApplicationController
  respond_to :html, :js
  before_action :set_user, only: [:show, :edit, :update, :destroy]
 
  def index
    search
  end

  # GET /admin/users/1
  # GET /admin/users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /admin/users/new
  def new
    @user = User.new 
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  # POST /admin/users.json
  def create
    search
    @user = User.new(user_params)
    @user.save
    @users = [@user]
    # respond_to do |format|
    #   if @user.save
    #     format.html { redirect_to [:admin, @user], notice: 'User was successfully created.' }
    #     format.json { render action: 'show', status: :created, location: @user }
    #   else
    #     format.html { render action: 'new' }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  

  # PATCH/PUT /admin/users/1
  # PATCH/PUT /admin/users/1.json
  def update
    if params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation) 
    end 
     respond_to do |format| 
        if @user.update(user_params) 
         search
         format.html { redirect_to [:admin, @user], notice: 'User was successfully updated.' }
         format.json { head :no_content }
         format.js
       else
         format.html { render :edit }
         format.json { render json: @user.errors, status: :unprocessable_entity }
         format.js
       end
      end  
  end
  
  def delete
    @user = User.find(params[:user_id])
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    @users = User.all
    @user = User.find(params[:id])
    @user.save!(context: :delete)
    search
  end

  def filter
  end

  def search(per_page = 10)
    params[:q] ||= {} 
    params[:per_page] = 10
    
    @q = User.search(params[:q])
    @users = @q.result(:distinct => true).page(params[:page]).per(params[:per_page])  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :paginate, :status )
    end
   
    
end
