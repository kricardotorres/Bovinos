class CreateNutritionalControls < ActiveRecord::Migration[5.1]
  def change
    create_table :nutritional_controls do |t|
      t.string :name
      t.string :purpouse
      t.date :from_date
      t.date :to_date

      t.timestamps
    end
  end
end
