class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :country
      t.string :address
      t.datetime :establish_year
      t.string :continents

      t.timestamps
    end
  end
end
