class Match < ApplicationRecord
  enum status: [:pending, :ready, :finish]

  belongs_to :team1, class_name: Team.name
  belongs_to :team2, class_name: Team.name
  belongs_to :round
  has_many :match_infos, dependent: :destroy
  has_many :score_sugests, dependent: :destroy
  has_one :match_result, dependent: :destroy
  has_many :score_bets, dependent: :destroy

  validates :team1_id, presence: true
  validates :team2_id, presence: true
  validates :round_id, presence: true

  scope :newest, ->{order date_of_match: :desc}

  delegate :name, to: :team1, prefix: true
  delegate :name, to: :team2, prefix: true
  delegate :name, to: :round, prefix: true

  def self.load_leagues
    League.newest.pluck(:name, :id)
  end

  def load_rounds
    return [[round_name, round_id]] if id.present?
    []
  end

  def load_teams
    Team.newest.pluck(:name, :id)
  end

  def self.select_status
    statuses.map{|c| [c[0].titleize, c[0]]}
  end
end
