class CreateCows < ActiveRecord::Migration[5.1]
  def change
    create_table :cows do |t|
      t.string :key_id
      t.string :name
      t.date :birthday
      t.date :deaddate
      t.datetime :deleted_at 
      t.timestamps
    end
  end
end
