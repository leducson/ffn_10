class Round < ApplicationRecord
  acts_as_paranoid
  belongs_to :league
  has_many :matches, dependent: :destroy

  scope :newest, ->{order created_at: :desc}
  scope :by_league, ->(league_id){where("league_id = ?", league_id).newest}

  delegate :name, to: :league, prefix: true
end
