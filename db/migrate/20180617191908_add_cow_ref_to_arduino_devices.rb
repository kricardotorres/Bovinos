class AddCowRefToArduinoDevices < ActiveRecord::Migration[5.1]
  def change
    add_reference :arduino_devices, :cow, foreign_key: true
  end
end
