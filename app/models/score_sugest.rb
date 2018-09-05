class ScoreSugest < ApplicationRecord
  belongs_to :match
  has_many :score_bets, dependent: :destroy

  validates :score_win, :score_lost, :ratio, :match_id, presence: true
end
