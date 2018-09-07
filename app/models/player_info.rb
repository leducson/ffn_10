class PlayerInfo < ApplicationRecord
  belongs_to :team
  has_many :match_infos
end
