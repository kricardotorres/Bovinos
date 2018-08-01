class ArduinoDevicesController < ApplicationController
  before_action :set_arduino_device, only: [:show, :edit, :update, :destroy ]

  # GET /arduino_devices
  # GET /arduino_devices.json
  def index
    @arduino_devices = ArduinoDevice.all
  end

  # GET /arduino_devices/1
  # GET /arduino_devices/1.json
  def show
  end

  def get_last_moves_x  


    @arduino_device = ArduinoDevice.find(params[:arduino_device_id]) 
   
    @arduino_device.cow_histories.last(15).each_with_index do |cow_historie, index|
      if @last_hist  
        diference = cow_historie.x.to_f -  @last_hist.x.to_f 
        puts "La vaca se inclino hacia al frente, Fecha: "+cow_historie.created_at.to_s if diference < -50
        puts "La vaca se inclino hacia a atras, Fecha:  "+cow_historie.created_at.to_s if diference > 50  
         diference = cow_historie.y.to_f -  @last_hist.y.to_f 
        puts "La vaca se inclino hacia la derecha, Fecha: "+cow_historie.created_at.to_s  if diference < -50
        puts "La vaca se inclino hacia la izquierda, Fecha: "+cow_historie.created_at.to_s if diference > 50  
        diference = cow_historie.z.to_f -  @last_hist.z.to_f 
       
        puts "La vaca se roto hacia la derecha, Fecha: "+cow_historie.created_at.to_s  if diference < -50
        puts "La vaca se roto hacia la  izquierda, Fecha: "+cow_historie.created_at.to_s  if diference > 50  
        puts "--------"
      end  
      @last_hist = cow_historie
    end 

    render json:  @arduino_device.cow_histories.pluck(:created_at,:x ).last(15) 
  end 


  def get_last_moves

    @total=''

    @arduino_device = ArduinoDevice.find(params[:arduino_device_id]) 
   
    @arduino_device.cow_histories.last(15).each_with_index do |cow_historie, index|
      if @last_hist  
        diference = cow_historie.x.to_f -  @last_hist.x.to_f 
        @total+= "<br> La vaca se inclino hacia al frente, Fecha: "+cow_historie.created_at.to_s if diference < -50
        @total+= "<br> La vaca se inclino hacia a atras, Fecha:  "+cow_historie.created_at.to_s if diference > 50  
         diference = cow_historie.y.to_f -  @last_hist.y.to_f 
        @total+= "<br> La vaca se inclino hacia la derecha, Fecha: "+cow_historie.created_at.to_s  if diference < -50
        @total+= "<br> La vaca se inclino hacia la izquierda, Fecha: "+cow_historie.created_at.to_s if diference > 50  
        diference = cow_historie.z.to_f -  @last_hist.z.to_f 
       
        @total+= "<br> La vaca se roto hacia la derecha, Fecha: "+cow_historie.created_at.to_s  if diference < -50
        @total+= "<br> La vaca se roto hacia la  izquierda, Fecha: "+cow_historie.created_at.to_s  if diference > 50  
         
      end  
      @last_hist = cow_historie

    end 
    render :layout => false
  end 

  def get_last_moves_y  

     @arduino_device = ArduinoDevice.find(params[:arduino_device_id])
      
     
    render json:  @arduino_device.cow_histories.pluck(:created_at,:y ).last(15) 
  end  
  def get_last_moves_z  

     @arduino_device = ArduinoDevice.find(params[:arduino_device_id])
     
    render json:  @arduino_device.cow_histories.pluck(:created_at,:z ).last(15) 
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
      params.require(:arduino_device).permit(:chipid, :model)
    end
end
