class AddCowRefToCarnets < ActiveRecord::Migration[5.1]
  def change
  	 add_reference :carnets, :cow, foreign_key: true
  end
end
