class Team < ApplicationRecord
  belongs_to :league
  has_many :player_infos, dependent: :destroy
  has_many :rankings, dependent: :destroy
  has_many :team1_matchs, class_name: Match.name,
    foreign_key: :team1_id,
    dependent: :destroy
  has_many :team2_matchs, class_name: Match.name,
    foreign_key: :team2_id,
    dependent: :destroy
end
