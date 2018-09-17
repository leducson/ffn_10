class ScoreBet < ApplicationRecord
  acts_as_paranoid
  enum status: [:win, :lost, :pending]
  belongs_to :user
  belongs_to :match
  belongs_to :score_sugest
  has_many :notifies, dependent: :destroy
  validates :price, :score_sugest_id, :match_id,
    :user_id, presence: true

  scope :newest, ->{order created_at: :desc}

  delegate :score_win, :score_lost, :ratio, to: :score_sugest, prefix: true
  delegate :fullname, :email, to: :user, prefix: true

  class << self
    def load_includes
      includes(:user, :score_sugest, match: [:team1, :team2]).newest
    end

    def load_status
      statuses.map{|k, v| [k, v]}
    end

    def load_teams
      Team.newest.pluck :name, :id
    end
  end

  def self.load_status
    statuses.map{|k, v| [k, v]}
  end

  def self.load_teams
    Team.newest.pluck :name, :id
  end
end
