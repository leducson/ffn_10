class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :downcase_email

  has_many :comments, dependent: :destroy
  has_many :notifies, dependent: :destroy
  has_many :credits, dependent: :destroy
  has_many :score_bets, dependent: :destroy

  validates :fullname, presence: true,
    length: {maximum: Settings.user.maximum_fullname}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.user.maximum_email},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.user.minimum_pass}, allow_nil: true

  scope :newest, ->{order created_at: :desc}

  def send_bet_info_match_info money_win, suguest, bet
    UserMailer.match_info(money_win, suguest, bet, self).deliver_now
  end

  def send_match_info_lost sugest, bet
    UserMailer.send_mail_lost_info(sugest, bet, self).deliver_now
  end

  def deduction bet_amount
    new_money = money - bet_amount
    update_attribute :money, new_money
  end

  private

  def downcase_email
    email.downcase!
  end
end
