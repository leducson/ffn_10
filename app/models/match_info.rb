class MatchInfo < ApplicationRecord
  enum type: [:goal, :goal_lost, :red_card, :yellow_card, :substitution]

  belongs_to :match
end
