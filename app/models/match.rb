class Match < ApplicationRecord
  belongs_to :team1, class_name: Team.name
  belongs_to :team2, class_name: Team.name
  has_many :match_infos, dependent: :destroy
  has_many :score_sugests, dependent: :destroy
  has_one :match_result, dependent: :destroy
  has_many :score_bets, dependent: :destroy

  validates :team1_id, presence: true
  validates :team2_id, presence: true
end
