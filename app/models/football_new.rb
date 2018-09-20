class FootballNew < ApplicationRecord
  acts_as_paranoid
  mount_uploader :image, ImageUploader

  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true

  scope :newest, ->{order created_at: :desc}
end
