class ChangeColumnScoreBets < ActiveRecord::Migration[5.2]
  def change
    change_column :score_bets, :status, :integer
  end
end
