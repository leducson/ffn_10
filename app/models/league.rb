class League < ApplicationRecord
  has_many :rounds, dependent: :destroy
  has_many :rankings, dependent: :destroy
  has_many :teams, dependent: :destroy
  belongs_to :continent, class_name: Continent.name, foreign_key: :continent_id
  belongs_to :country, class_name: Country.name, foreign_key: :country_id

  scope :newest, ->{order created_at: :desc}

  delegate :name, to: :country, prefix: true

  def self.load_continents
    Continent.pluck(:name, :id)
  end
end
