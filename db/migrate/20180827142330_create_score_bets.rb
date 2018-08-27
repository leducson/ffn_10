class CreateScoreBets < ActiveRecord::Migration[5.2]
  def change
    create_table :score_bets do |t|
      t.float :price
      t.string :status
      t.references :score_sugest, index: true, foreign_key: true
      t.references :match, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
