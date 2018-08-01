class AddArduinoDeviceRefToCowHistories < ActiveRecord::Migration[5.1]
  def change
    add_reference :cow_histories, :arduino_device, foreign_key: true
  end
end
