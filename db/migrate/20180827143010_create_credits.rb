class CreateCredits < ActiveRecord::Migration[5.2]
  def change
    create_table :credits do |t|
      t.string :type
      t.float :amount
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
