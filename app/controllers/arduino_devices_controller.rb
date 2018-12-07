class ArduinoDevicesController < ApplicationController
  before_action :set_arduino_device, only: [:show, :edit, :update, :destroy  ]
   skip_before_action :authenticate_user!, :only => [:show]
  # GET /arduino_devices
  # GET /arduino_devices.json
  def index
    @arduino_devices = ArduinoDevice.all
  end
  def search
    @arduino_device = ArduinoDevice.find(params[:arduino_device_id])
    show
    render :show
  end
  # GET /arduino_devices/1
  # GET /arduino_devices/1.json
  def show
     
    

    params[:q] ||= {}
    params[:q][:created_at]= Date.today unless params[:q][:created_at] 
    @q = @arduino_device.cow_histories.search(params[:q])
    @current_date= params[:q][:created_at]
    load_moves

  end
  def get_report
    
    # @arduino_device = ArduinoDevice.find(params[:arduino_device_id]) 
    # params[:q] ||= {}
    # params[:q][:created_at]= Date.today unless params[:q][:created_at] 
    # @q = @arduino_device.cow_histories.search(params[:q])
    # @current_date= params[:q][:created_at]
    # load_moves
    # respond_to do |format|
    #   format.html
    #   format.pdf do
    #     render pdf: "get_report" ,javascript_delay: 5000   # Excluding ".pdf" extension.
    #   end
    # end
  end
  def set_date
    @current_date = params[:current_date]
  end

  def get_last_moves_x  


    @arduino_device = ArduinoDevice.find(params[:arduino_device_id])  
 

    render json:  @arduino_device.cow_histories.where("cow_histories.created_at>=?", params[:current_date]  ).pluck(:created_at,:x ).last(100) 
  end 


  def get_last_moves
    @arduino_device = ArduinoDevice.find(params[:arduino_device_id]) 
    set_date
   load_moves
    render :layout => false
  end 
 def load_moves
    @caminando=0
    @parada=0
    @sentada=0
    @dormida=0

    @total='' 
   
    @arduino_device.cow_histories.where("cow_histories.created_at>=?", @current_date ).each_with_index do |cow_historie, index|
      
      if @last_hist  
        @is_moving =false
        diference_movement = cow_historie.y.to_f -  @last_hist.y.to_f  
        @is_moving =true if diference_movement>5||diference_movement<-5 
        diference = cow_historie.z.to_f -  @last_hist.z.to_f 
        @direccion=""
        @direccion= "  hacia la derecha  "   if diference < -500
        @direccion=" hacia la  izquierda  "  if diference > 500 
       #@total+= "<br>La vaca esta caminando"+@direccion+", Fecha:"+cow_historie.created_at.utc.to_s if @is_moving
        if ((diference < -500)||(diference > 500))&&@is_moving
          created = @last_hist.created_at 
          updated = cow_historie.created_at  
          @caminando+= ((updated - created)  ).to_f if (((updated - created) ))<100 
          @current_state="cowwalking.gif"
       end
        if (70..90).include?(cow_historie.x.to_f)&&(-10..15).include?(cow_historie.y.to_f)&&(70..90).include?(@last_hist.x.to_f)&&(-10..15).include?(@last_hist.y.to_f)&&!@is_moving
          created = @last_hist.created_at
          updated = cow_historie.created_at 
          @parada+= ((updated - created) ).to_f if (((updated - created) ))<100
          @current_state="vacas_parada.gif"
       end
       #@total+= "<br>La vaca esta parada/quieta, Fecha:"+cow_historie.created_at.utc.to_s if (70..90).include?(cow_historie.x.to_f)&&(-10..15).include?(cow_historie.y.to_f)&&(70..90).include?(@last_hist.x.to_f)&&(-10..15).include?(@last_hist.y.to_f)&&!@is_moving
       #
       if (-20..19).include?(cow_historie.x.to_f)&&(-90..-63).include?(cow_historie.y.to_f)&&(-20..19).include?(@last_hist.x.to_f)&&(-90..-63).include?(@last_hist.y.to_f)
          created = @last_hist.created_at
          updated = cow_historie.created_at 
          @sentada+= ((updated - created) ).to_f if (((updated - created) ))<100
          @current_state="vaca_acostada.jpg"
       end
       #@total+= "<br>La vaca esta sentada, Fecha:"+cow_historie.created_at.utc.to_s if (-20..19).include?(cow_historie.x.to_f)&&(-90..-63).include?(cow_historie.y.to_f)&&(-20..19).include?(@last_hist.x.to_f)&&(-90..-63).include?(@last_hist.y.to_f)
      
       if (15..27).include?(cow_historie.x.to_f)&&(0..31).include?(cow_historie.y.to_f)&&(15..27).include?(@last_hist.x.to_f)&&(0..31).include?(@last_hist.y.to_f)        
          created = @last_hist.created_at 
          updated = cow_historie.created_at   
          @dormida+= ((updated - created) ).to_f if (((updated - created) ))<100 
          @current_state="vaca_durmiendo.jpg" 
       end
       #@total+= "<br>La vaca esta durmiendo, Fecha:"+cow_historie.created_at.utc.to_s if (15..27).include?(cow_historie.x.to_f)&&(0..31).include?(cow_historie.y.to_f)&&(15..27).include?(@last_hist.x.to_f)&&(0..31).include?(@last_hist.y.to_f) 
      end  
      @last_hist = cow_historie 
    end 
    
  end 
   def get_cow_state

    @total=''

    @arduino_device = ArduinoDevice.find(params[:arduino_device_id]) 
   
    @arduino_device.cow_histories.where("cow_histories.created_at>=?", params[:current_date] ).last(50).each_with_index do |cow_historie, index|
        
        
         cow_historie.x.to_f  
       
       
     
    end  
  end 

  def get_last_moves_y  

     @arduino_device = ArduinoDevice.find(params[:arduino_device_id])
      
     
    render json:  @arduino_device.cow_histories.where("cow_histories.created_at>=?", params[:current_date] ).pluck(:created_at,:y ).last(100) 
  end  
  def get_last_moves_z  

     @arduino_device = ArduinoDevice.find(params[:arduino_device_id])
     
    render json:  @arduino_device.cow_histories.where("cow_histories.created_at>=?", params[:current_date]  ).pluck(:created_at,:z ).last(100) 
  end  
  # GET /arduino_devices/new
  def new
    @arduino_device = ArduinoDevice.new
  end

  # GET /arduino_devices/1/edit
  def edit
  end

  # POST /arduino_devices
  # POST /arduino_devices.json
  def create 

    respond_to do |format|
      if current_user.arduino_devices.create(arduino_device_params)
        format.html { redirect_to arduino_devices_url, notice: 'Arduino device was successfully created.' }
        format.json { render :show, status: :created, location: @arduino_device }
      else
        format.html { render :new }
        format.json { render json: @arduino_device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /arduino_devices/1
  # PATCH/PUT /arduino_devices/1.json
  def update
    respond_to do |format|
      if @arduino_device.update(arduino_device_params)
        format.html { redirect_to @arduino_device, notice: 'Arduino device was successfully updated.' }
        format.json { render :show, status: :ok, location: @arduino_device }
      else
        format.html { render :edit }
        format.json { render json: @arduino_device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /arduino_devices/1
  # DELETE /arduino_devices/1.json
  def destroy
    @arduino_device.destroy
    respond_to do |format|
      format.html { redirect_to arduino_devices_url, notice: 'Arduino device was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_arduino_device
      @arduino_device = ArduinoDevice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def arduino_device_params
      params.require(:arduino_device).permit(:chipid, :model, :cow_id)
    end
end
