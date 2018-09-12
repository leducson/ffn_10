class RemoveColumnMatchResults < ActiveRecord::Migration[5.2]
  def change
    remove_column :match_results, :score_win
    remove_column :match_results, :score_lost
    remove_column :match_results, :win_team_id
    remove_column :match_results, :lost_team_id
    add_column :match_results, :score, :integer
    add_column :match_results, :team_id, :integer
  end
end
