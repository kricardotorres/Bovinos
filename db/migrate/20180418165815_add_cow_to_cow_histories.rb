class AddCowToCowHistories < ActiveRecord::Migration[5.1]
  def change
    add_reference :cow_histories, :cow, foreign_key: true
  end
end
