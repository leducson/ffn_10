class DefaultTimeMatches < ActiveRecord::Migration[5.2]
  def change
    change_column :matches, :time, :integer, default: 0
  end
end
