class CreateArduinoDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :arduino_devices do |t|
      t.string :chipid
      t.string :model

      t.timestamps
    end
  end
end
