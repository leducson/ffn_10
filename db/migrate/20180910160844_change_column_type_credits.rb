class ChangeColumnTypeCredits < ActiveRecord::Migration[5.2]
  def change
    change_column :credits, :credit_type, :integer
  end
end
