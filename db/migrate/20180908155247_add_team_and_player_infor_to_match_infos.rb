class AddTeamAndPlayerInforToMatchInfos < ActiveRecord::Migration[5.2]
  def change
    add_column :match_infos, :team_id, :integer
    add_column :match_infos, :player_info_id, :integer
  end
end
