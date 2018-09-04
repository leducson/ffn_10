class ChangeTableLeagueAndTeam < ActiveRecord::Migration[5.2]
  def change
    remove_column :leagues, :continents, :string
    remove_column :leagues, :country, :string
    add_column :leagues, :continent_id, :integer
    add_column :leagues, :country_id, :integer

    remove_column :teams, :continents, :string
    remove_column :teams, :country, :string
    add_column :teams, :continent_id, :integer
    add_column :teams, :country_id, :integer
  end
end
