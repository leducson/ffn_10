class ScoreBet < ApplicationRecord
  enum status: [:win, :lost]

  belongs_to :match
  belongs_to :score_sugest
  has_many :notifies, dependent: :destroy
  validates :price, :status, :score_sugest_id, :match_id,
    :user_id, presence: true
end
