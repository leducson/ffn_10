class ScoreBet < ApplicationRecord
  enum status: [:win, :lost]
  belongs_to :user
  belongs_to :match
  belongs_to :score_sugest
  has_many :notifies, dependent: :destroy
  validates :price, :score_sugest_id, :match_id,
    :user_id, presence: true
  delegate :score_win, :score_lost, :ratio, to: :score_sugest, prefix: true
end
