class Round < ApplicationRecord
  belongs_to :league
  has_many :matches, dependent: :destroy

  scope :newest, ->{order created_at: :desc}
end
