class User < ApplicationRecord
  has_many :created_events,     class_name:   "Event",
                                foreign_key:  "creator_id"
  has_many :invitations,        foreign_key:  "attendee_id"
  has_many :attended_events,    through:      :invitations


  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: {case_sensitive: false }
  has_secure_password
  before_create :create_remember_digest
  validates :password, length: { minimum: 6 }, allow_blank: true

  #remembers a user in the database for use in persistent sessions
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  # forget use from database in persistent sessions
  def forget
    update_attribute(:remember_digest, nil)
  end

  #create a random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # make into digest
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  private

  def create_remember_digest
    self.remember_token = User.new_token
    self.remember_digest = User.digest(remember_token)
  end

end
