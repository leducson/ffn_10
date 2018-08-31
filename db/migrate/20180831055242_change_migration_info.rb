class ChangeMigrationInfo < ActiveRecord::Migration[5.2]
  def change
    remove_index :match_results, :win_team_id
    remove_index :match_results, :lost_team_id

    create_table :match_infos do |t|
      t.string :message
      t.integer :minutes
      t.integer :type_info
      t.references :match, index: true, foreign_key: true

      t.timestamps
    end

    add_reference :teams, :league, foreign_key: true

    rename_column :matches, :team_id1, :team1_id
    rename_column :matches, :team_id2, :team2_id

    add_column :player_infos, :number, :integer

    remove_index :matches, :team1_id
    remove_index :matches, :team2_id

    rename_column :credits, :type, :credit_type
  end
end
