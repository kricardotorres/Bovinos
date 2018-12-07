class CreateNutritionalControlHasAliments < ActiveRecord::Migration[5.1]
  def change
    create_table :nutritional_control_has_aliments do |t|
    	t.timestamps
    end

	add_reference :nutritional_control_has_aliments, :aliment, foreign_key: true
	add_reference :nutritional_control_has_aliments, :nutritional_control, foreign_key: true
  end
end
