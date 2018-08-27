class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :message
      t.references :user, index: true, foreign_key: true
      t.references :football_new, index: true, foreign_key: true
      t.timestamps
    end
  end
end
