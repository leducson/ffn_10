class Match < ApplicationRecord
  enum status: [:pending, :ready, :finish]

  belongs_to :team1, class_name: Team.name
  belongs_to :team2, class_name: Team.name
  belongs_to :round
  has_many :match_infos, dependent: :destroy
  has_many :score_sugests, dependent: :destroy
  has_many :match_results, dependent: :destroy
  has_many :score_bets, dependent: :destroy

  validates :team1_id, presence: true
  validates :team2_id, presence: true
  validates :round_id, presence: true

  scope :newest, ->{order date_of_match: :desc}
  scope :ranger_date_match, ->(date){where("date_of_match <= ?", date)}

  delegate :name, to: :team1, prefix: true
  delegate :name, to: :team2, prefix: true
  delegate :name, to: :round, prefix: true

  def self.load_leagues
    League.newest.pluck(:name, :id)
  end

  def load_rounds
    return [[round_name, round_id]] if id.present?
    []
  end

  def load_teams
    Team.newest.pluck(:name, :id)
  end

  def self.select_status
    statuses.map{|c| [c[0].titleize, c[0]]}
  end

  def load_teams_match_infos
    [[team1_name, team1_id], [team2_name, team2_id]]
  end

  def get_score_team1
    match_results.find_by team_id: team1_id
  end

  def get_score_team2
    match_results.find_by team_id: team2_id
  end

  def check_finish_match
    return unless score_bets.present?
    score_bets.each do |s|
      sugest = [s.score_sugest_score_win, s.score_sugest_score_lost]
      if sugest == format_score_match
        send_mail_after_match_end s, sugest
      else
        s.lost!
      end
    end
  end

  def send_mail_after_match_end bet, sugest
    bet.win!
    money_win = (bet.score_sugest.ratio.to_i * bet.price.to_f)
    new_money = bet.user.money.to_f + money_win
    bet.user.update_attributes money: new_money
    bet.user.send_bet_info_match_info money_win, sugest, bet
  end

  def format_score_match
    [get_score_team1.score, get_score_team2.score]
  end
end
