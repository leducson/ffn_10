class CreateLeagues < ActiveRecord::Migration[5.2]
  def change
    create_table :leagues do |t|
      t.string :name
      t.string :country
      t.datetime :start_date
      t.datetime :end_date
      t.string :continents
      t.integer :number_of_match
      t.integer :number_of_team
      t.integer :match_time
      t.integer :number_of_round

      t.timestamps
    end
  end
end
