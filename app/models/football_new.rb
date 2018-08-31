class FootballNew < ApplicationRecord
  mount_uploader :image, ImageUploader

  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true

  scope :newest, ->{order created_at: :desc}
end
