class Aliment < ApplicationRecord
	has_many :nutritional_control_has_aliments
	has_many :nutritional_control, through: :nutritional_control_has_aliments 
end
