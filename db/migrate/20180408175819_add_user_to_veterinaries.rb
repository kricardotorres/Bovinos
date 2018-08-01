class AddUserToVeterinaries < ActiveRecord::Migration[5.1]
  def change
    add_reference :veterinaries, :user, foreign_key: true
  end
end
