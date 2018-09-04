class Country < ApplicationRecord
  belongs_to :continent
  has_many :teams, dependent: :destroy
  has_many :leagues, dependent: :destroy
end
