class CreateAliments < ActiveRecord::Migration[5.1]
  def change
    create_table :aliments do |t|
      t.string :name

      t.timestamps
    end
  end
end
