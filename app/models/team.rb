class Team < ApplicationRecord
  mount_uploader :image, ImageUploader

  has_many :player_infos, dependent: :destroy
  has_many :match_infos
  has_many :rankings, dependent: :destroy
  belongs_to :continent, class_name: Continent.name, foreign_key: :continent_id
  belongs_to :country, class_name: Country.name, foreign_key: :country_id
  belongs_to :league, optional: true
  has_many :team1_matchs, class_name: Match.name,
    foreign_key: :team1_id,
    dependent: :destroy
  has_many :team2_matchs, class_name: Match.name,
    foreign_key: :team2_id,
    dependent: :destroy

  scope :newest, ->{order created_at: :desc}
  scope :by_country, ->(country_id){where(country_id: country_id)}

  delegate :name, to: :continent, prefix: true
  delegate :name, to: :country, prefix: true

  def self.load_continents
    Continent.pluck(:name, :id)
  end

  def load_countries
    return continent.countries.pluck(:name, :id) if id.present?
    []
  end

  def self.load_leagues
    League.newest.pluck(:name, :id)
  end

  def self.load_players
    PlayerInfo.where(team_id: nil).newest.pluck :name, :id
  end

  def create_ranking
    return unless league_id.present?
    rankings.create!(league_id: league_id, rank: 1)
  end
end
