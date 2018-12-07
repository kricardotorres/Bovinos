class CowHistory < ApplicationRecord
    belongs_to :arduino_device
	belongs_to :cow 

scope :today, -> { where(created_at: DateTime.now.beginning_of_day..DateTime.now.end_of_day) }


end
