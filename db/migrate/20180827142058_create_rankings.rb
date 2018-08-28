class CreateRankings < ActiveRecord::Migration[5.2]
  def change
    create_table :rankings do |t|
      t.integer :rank
      t.references :league, index: true, foreign_key: true
      t.references :team, index: true, foreign_key: true

      t.timestamps
    end
  end
end
