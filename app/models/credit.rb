class Credit < ApplicationRecord
  acts_as_paranoid
  enum credit_type: [:pay_bet, :recharge, :request]

  belongs_to :user

  validates :user_id, :amount, presence: true

  scope :newest, ->{order created_at: :desc}

  delegate :fullname, to: :user, prefix: true

  class << self
    def load_types
      credit_types.map{|t| [t[0].titleize, t[0]]}
    end

    def load_users
      User.newest.pluck :fullname, :id
    end
  end
end
