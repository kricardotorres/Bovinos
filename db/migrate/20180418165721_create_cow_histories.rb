class CreateCowHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :cow_histories do |t|
      t.string :x
      t.string :y
      t.string :z

      t.timestamps
    end
  end
end
