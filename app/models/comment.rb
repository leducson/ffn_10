class Comment < ApplicationRecord
  acts_as_paranoid
  belongs_to :football_new
  belongs_to :user

  validates :user_id, presence: true
  validates :message, presence: true
  validates :football_new_id, presence: true

  scope :newest, ->{order created_at: :desc}

  delegate :fullname, :email, to: :user, prefix: true

  def get_user
    user_email unless user_fullname.present?
    user_fullname
  end
end
