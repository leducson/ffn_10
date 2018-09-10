class PlayerInfo < ApplicationRecord
  enum gender: [:male, :female]
  enum position: [:goalkeeper, :defenders, :midfielders, :attackers]

  belongs_to :team, optional: true
  has_many :match_infos

  scope :newest, ->{order created_at: :desc}

  delegate :name, to: :team, prefix: true, allow_nil: true

  def self.load_genders
    genders.map{|g| [g[0].titleize, g[0]]}
  end

  def self.load_teams
    Team.newest.pluck :name, :id
  end

  def self.load_positions
    positions.map{|p| [p[0].titleize, p[0]]}
  end
end
