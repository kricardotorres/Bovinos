class ArduinoDevice < ApplicationRecord
	belongs_to :user
	belongs_to :cow  
	has_many :cow_histories 
end
