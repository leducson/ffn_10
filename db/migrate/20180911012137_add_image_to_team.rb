class AddImageToTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :image, :string
    add_column :leagues, :image, :string
  end
end
