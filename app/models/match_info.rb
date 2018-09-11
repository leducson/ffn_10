class MatchInfo < ApplicationRecord
  enum type_info: [:goal, :goal_lost, :red_card, :yellow_card, :substitution]

  belongs_to :match
  belongs_to :player_info, class_name: PlayerInfo.name,
    foreign_key: :player_info_id
  belongs_to :team, class_name: Team.name, foreign_key: :team_id

  scope :newest, ->{order minutes: :desc}

  delegate :name, to: :team, prefix: true, allow_nil: true
  delegate :name, :number, to: :player_info, prefix: true, allow_nil: true

  def self.load_types
    type_infos.map{|c| [c[0].titleize, c[0]]}
  end

  def format_player
    "#{player_info_name} (#{player_info_number})" if player_info.present?
  end

  def load_team_infos
    [[match.team1_name, match.team1_id], [match.team2_name, match.team2_id]]
  end

  def load_players
    if team.present?
      team.player_infos.map{|p| ["#{p.name} (#{p.number})", p.id]}
    else
      []
    end
  end
end
