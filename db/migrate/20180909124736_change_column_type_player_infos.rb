class ChangeColumnTypePlayerInfos < ActiveRecord::Migration[5.2]
  def change
    change_column :player_infos, :gender, :integer
    change_column :player_infos, :position, :integer
  end
end
