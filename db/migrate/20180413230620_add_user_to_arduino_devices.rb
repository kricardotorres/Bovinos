class AddUserToArduinoDevices < ActiveRecord::Migration[5.1]
  def change
    add_reference :arduino_devices, :user, foreign_key: true
  end
end
