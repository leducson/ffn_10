class CreateFootballNews < ActiveRecord::Migration[5.2]
  def change
    create_table :football_news do |t|
      t.string :title
      t.text :content
      t.string :image

      t.timestamps
    end
  end
end
