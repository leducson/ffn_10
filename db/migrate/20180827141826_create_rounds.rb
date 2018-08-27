class CreateRounds < ActiveRecord::Migration[5.2]
  def change
    create_table :rounds do |t|
      t.string :name
      t.references :league, index: true, foreign_key: true
      t.references :match, index: true, foreign_key: true

      t.timestamps
    end
  end
end
