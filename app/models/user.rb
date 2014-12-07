class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
  format:     { with: VALID_EMAIL_REGEX },
  uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
  before_create :create_remember_token # arranges for Rails to look for a method called create_remember_token and run it before saving the user

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy


  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def self.search(search)
     where("name like ?", "#{search}")
  end

  private

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end
end
