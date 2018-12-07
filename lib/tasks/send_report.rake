namespace :send_report do
	desc "envia reportes de usuarios"
	task :send_cow_report  => :environment do
		ArduinoDevice.all.each do |arduino_device|
			@caminando=0
		    @parada=0
		    @sentada=0
		    @dormida=0

		    @total='' 
		   
		    arduino_device.cow_histories.where("cow_histories.created_at>=?", Date.today ).each_with_index do |cow_historie, index|
		      
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
			WarningMailer.report(arduino_device, @dormida, @sentada, @parada,@caminando,Date.today,@current_state).deliver 
		end

	end
end
