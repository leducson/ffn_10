class AddDeletedAtToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :deleted_at, :datetime
    add_index :users, :deleted_at

    add_column :teams, :deleted_at, :datetime
    add_index :teams, :deleted_at

    add_column :score_sugests, :deleted_at, :datetime
    add_index :score_sugests, :deleted_at

    add_column :score_bets, :deleted_at, :datetime
    add_index :score_bets, :deleted_at

    add_column :rounds, :deleted_at, :datetime
    add_index :rounds, :deleted_at

    add_column :player_infos, :deleted_at, :datetime
    add_index :player_infos, :deleted_at

    add_column :match_infos, :deleted_at, :datetime
    add_index :match_infos, :deleted_at

    add_column :matches, :deleted_at, :datetime
    add_index :matches, :deleted_at

    add_column :leagues, :deleted_at, :datetime
    add_index :leagues, :deleted_at

    add_column :football_news, :deleted_at, :datetime
    add_index :football_news, :deleted_at

    add_column :countries, :deleted_at, :datetime
    add_index :countries, :deleted_at

    add_column :notifies, :deleted_at, :datetime
    add_index :notifies, :deleted_at

    add_column :match_results, :deleted_at, :datetime
    add_index :match_results, :deleted_at

    add_column :comments, :deleted_at, :datetime
    add_index :comments, :deleted_at

    add_column :credits, :deleted_at, :datetime
    add_index :credits, :deleted_at

    add_column :rankings, :deleted_at, :datetime
    add_index :rankings, :deleted_at
  end
end
