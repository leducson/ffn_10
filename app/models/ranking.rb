class Ranking < ApplicationRecord
  belongs_to :league
  belongs_to :team

  scope :newest, ->{order rank: :desc}

  delegate :name, to: :team, prefix: true
end
