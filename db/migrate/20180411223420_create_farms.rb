class CreateFarms < ActiveRecord::Migration[5.1]
  def change
    create_table :farms do |t|
      t.string :name
      t.string :address
      t.date :fundation

      t.timestamps
    end
  end
end
