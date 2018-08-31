class Comment < ApplicationRecord
  belongs_to :football_new

  validates :user_id, presence: true
  validates :message, presence: true
  validates :football_new_id, presence: true
end
