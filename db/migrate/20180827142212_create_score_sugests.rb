class CreateScoreSugests < ActiveRecord::Migration[5.2]
  def change
    create_table :score_sugests do |t|
      t.integer :score_win
      t.integer :score_lost
      t.integer :ratio
      t.references :match, index: true, foreign_key: true

      t.timestamps
    end
  end
end
