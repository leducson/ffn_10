class Notify < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :score_bet, optional: true

  scope :newest, ->{order created_at: :desc}
end
