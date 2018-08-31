class Credit < ApplicationRecord
  enum type: [:pay_bet, :recharge]

  belongs_to :user

  validates :user_id, :amount, presence: true
end
