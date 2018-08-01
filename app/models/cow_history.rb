class CowHistory < ApplicationRecord
    belongs_to :arduino_device
	belongs_to :cow 

end
