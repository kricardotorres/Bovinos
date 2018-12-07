class NutritionalControl < ApplicationRecord
	 
	has_many :nutritional_control_has_aliments
	has_many :aliments , through: :nutritional_control_has_aliments 
end
