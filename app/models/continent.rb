class Continent < ApplicationRecord
  has_many :teams, dependent: :destroy
  has_many :leagues, dependent: :destroy
  has_many :countries, dependent: :destroy
end
