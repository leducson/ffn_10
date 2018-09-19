class MatchResult < ApplicationRecord
  belongs_to :match
  belongs_to :team, class_name: Team.name, foreign_key: :team_id

  validates :team_id, :match_id, presence: true

  scope :check_score, (lambda do |match_id, team_id|
    where(match_id: match_id, team_id: team_id)
  end)

  delegate :name, to: :team, prefix: true, allow_nil: true
end
