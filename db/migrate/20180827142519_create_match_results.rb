class CreateMatchResults < ActiveRecord::Migration[5.2]
  def change
    create_table :match_results do |t|
      t.integer :score_win
      t.integer :score_lost
      t.references :match, index: true, foreign_key: true
      t.integer :win_team_id
      t.integer :lost_team_id

      t.timestamps
    end
    add_index :match_results, :win_team_id, unique: true
    add_index :match_results, :lost_team_id, unique: true
  end
end
