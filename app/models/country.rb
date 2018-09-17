class Country < ApplicationRecord
  belongs_to :continent
  has_many :teams, dependent: :destroy
  has_many :leagues, dependent: :destroy

  scope :newest, ->{order created_at: :desc}

  delegate :name, to: :continent, prefix: true

  class << self
    def load_continents
      Continent.pluck(:name, :id)
    end
  end
end
