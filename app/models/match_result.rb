class MatchResult < ApplicationRecord
  belongs_to :match

  validates :score_win, :score_lost, :win_team_id, :lost_team_id,
    :match_id, presence: true
  validate :score_lost_less_than_score_win

  def score_lost_less_than_score_win
    return unless score_lost > score_win
    errors.add(:score_lost, "should be less than score win")
  end
end
