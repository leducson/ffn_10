class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false, default: ""
      t.string :fullname
      t.string :gender
      t.string :password_digest
      t.string :activation_digest
      t.string :remember_me_digest
      t.boolean :activated, default: false
      t.datetime :activated_at
      t.string :reset_digest
      t.datetime :reset_sent_at
      t.boolean :admin, default: false
      t.float :money

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
