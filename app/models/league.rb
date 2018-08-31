class League < ApplicationRecord
  has_many :rounds, dependent: :destroy
  has_many :rankings, dependent: :destroy
  has_many :teams
end
