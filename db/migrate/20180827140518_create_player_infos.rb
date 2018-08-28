class CreatePlayerInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :player_infos do |t|
      t.string :name
      t.datetime :date_of_birth
      t.string :gender
      t.integer :weight
      t.integer :height
      t.string :position
      t.references :team, index: true, foreign_key: true

      t.timestamps
    end
  end
end
