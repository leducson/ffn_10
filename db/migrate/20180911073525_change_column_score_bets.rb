class ChangeColumnScoreBets < ActiveRecord::Migration[5.2]
  def change
    change_column :score_bets, :status, :integer, using: "status::integer"
  end
end
