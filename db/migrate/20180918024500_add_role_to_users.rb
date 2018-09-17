class AddRoleToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :integer, default: 2
    remove_column :users, :activated, :boolean
    remove_column :users, :admin, :boolean
  end
end
