class ScoreSugest < ApplicationRecord
  belongs_to :match
  has_many :score_bets, dependent: :destroy

  validates :score_win, :score_lost, :ratio, :match_id, presence: true

  scope :newest, ->{order created_at: :desc}

  def create_bet user, price
    bet = score_bets.create(match_id: match_id, price: price,
      user_id: user.id, status: 2)
    create_notifies user.fullname, bet
    user.deduction price
  end

  def create_notifies fullname, bet
    score = "#{score_win} - #{score_lost}"
    match_team = "#{match.team1_name} - #{match.team2_name}"
    message = I18n.t("notifies.message", fullname: fullname,
      score: score, match_team: match_team)
    admin_user = User.find_by role: :admin
    bet.notifies.create!(user_id: admin_user.id, message: message)
  end
end
