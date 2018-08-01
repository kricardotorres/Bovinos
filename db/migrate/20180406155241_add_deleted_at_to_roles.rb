class AddDeletedAtToRoles < ActiveRecord::Migration[5.1]
  def change
    add_column :roles, :deleted_at, :datetime
  end
end
