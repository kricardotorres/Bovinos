class CreateVeterinaries < ActiveRecord::Migration[5.1]
  def change
    create_table :veterinaries do |t|
      t.string :clinic
      t.string :phone
      t.string :web_site      
      t.string :address
      t.timestamps
    end
  end
end
