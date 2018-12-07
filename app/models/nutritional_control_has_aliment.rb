class NutritionalControlHasAliment < ApplicationRecord
	belongs_to :aliment
	belongs_to :nutritional_control
end
