class User < ApplicationRecord
  before_create :create_activation_digest
  before_save :downcase_email
  attr_accessor :activation_token, :reset_token, :remember_token

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
  has_secure_password

  scope :newest, ->{order created_at: :desc}

  def self.digest string
    cost =
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns reset_digest: User.digest(reset_token),
      reset_sent_at: Time.zone.now
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def activate
    update_columns activated: true, activated_at: Time.zone.now
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def send_bet_info_match_info money_win, suguest, bet
    UserMailer.match_info(money_win, suguest, bet, self).deliver_now
  end

  def send_match_info_lost sugest, bet
    UserMailer.send_mail_lost_info(sugest, bet, self).deliver_now
  end

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_me_digest, User.digest(remember_token)
  end

  def forget
    update_attribute :remember_me_digest, nil
  end

  def password_reset_expired?
    reset_sent_at < Settings.user.expire.hours.ago
  end

  def deduction bet_amount
    new_money = money - bet_amount
    update_attribute :money, new_money
  end

  private

  def downcase_email
    email.downcase!
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
