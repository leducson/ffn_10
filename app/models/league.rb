class League < ApplicationRecord
  acts_as_paranoid
  mount_uploader :image, ImageUploader

  has_many :rounds, dependent: :destroy
  has_many :rankings, dependent: :destroy
  has_many :teams, dependent: :destroy
  belongs_to :continent, class_name: Continent.name, foreign_key: :continent_id
  belongs_to :country, class_name: Country.name, foreign_key: :country_id

  scope :newest, ->{order created_at: :desc}

  delegate :name, to: :country, prefix: true
  delegate :name, to: :continent, prefix: true

  def load_countries
    return continent.countries.pluck(:name, :id) if id.present?
    []
  end

  class << self
    def load_continents
      Continent.pluck(:name, :id)
    end
    
    def load_teams
      Team.where(league_id: nil).newest.pluck(:name, :id)
    end
  end
end
