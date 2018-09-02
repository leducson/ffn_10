class League < ApplicationRecord
  has_many :rounds, dependent: :destroy
  has_many :rankings, dependent: :destroy
  has_many :teams, dependent: :destroy

  scope :newest, ->{order created_at: :desc}
end
