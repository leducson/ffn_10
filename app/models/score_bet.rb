class ScoreBet < ApplicationRecord
  enum status: [:win, :lost]
  belongs_to :user
  belongs_to :match
  belongs_to :score_sugest
  has_many :notifies, dependent: :destroy
  validates :price, :score_sugest_id, :match_id,
    :user_id, presence: true

  scope :newest, ->{order created_at: :desc}

  delegate :score_win, :score_lost, :ratio, to: :score_sugest, prefix: true
  delegate :fullname, :email, to: :user, prefix: true

  def self.load_includes
    includes(:user, :score_sugest, match: [:team1, :team2]).newest
  end
end
