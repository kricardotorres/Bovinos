class Cow < ApplicationRecord
	has_many :cow_histories
	has_many :arduino_devices
	has_one :carnet
end
