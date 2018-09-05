class Team < ApplicationRecord
  belongs_to :league
  has_many :player_infos, dependent: :destroy
  has_many :rankings, dependent: :destroy
  belongs_to :continent, class_name: Continent.name, foreign_key: :continent_id
  belongs_to :country, class_name: Country.name, foreign_key: :country_id
  has_many :team1_matchs, class_name: Match.name,
    foreign_key: :team1_id,
    dependent: :destroy
  has_many :team2_matchs, class_name: Match.name,
    foreign_key: :team2_id,
    dependent: :destroy

  scope :newest, ->{order created_at: :desc}

  def self.load_continents
    Continent.pluck(:name, :id)
  end

  def load_countries
    return continent.countries.pluck(:name, :id) if id.present?
    []
  end
end
