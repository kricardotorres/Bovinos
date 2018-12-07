class WarningMailer < ApplicationMailer
	default from: "Bovino@bovine.com"
	layout false, :only => 'report'
 def warning_behave( cow)
    
    @cow = cow
    mail(from: "Bovino@bovine.com",to: "ricardoantoniomedinatorres@gmail.com", subject: 'Comportamiento peligroso')
  end
   def report(  arduino_device, dormida, sentada, parada,caminando,current_date,current_state)
    
    @arduino_device = arduino_device
    @dormida = dormida
    @sentada = sentada
    @parada = parada
    @current_date = current_date
    @caminando = caminando
    @current_state = current_state
    mail(from: "Bovino@bovine.com",to: "ricardoantoniomedinatorres@gmail.com", subject: 'Reporte Del Día')
  end
end
