class FootballNew < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :content, presence: true

  scope :newest, ->{order created_at: :desc}
end
