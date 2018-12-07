class CreateCarnets < ActiveRecord::Migration[5.1]
  def change
    create_table :carnets do |t|
      t.string :earing_sup
      t.string :earing_inf
      t.string :vacune
      t.date :aplication_date
      t.decimal :weight

      t.timestamps
    end
  end
end
