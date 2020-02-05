class User < ApplicationRecord
  has_secure_password

  PASSWORD_COST = 10

  validates :email, presence: true
  validates :password_digest, presence: true

  has_many :user_movies
  has_many :movies, through: :user_movies

  # Generates & store in`password_digest` to store the hashed password.
  def password=(new_password)
    @password = new_password
    self.password_digest = create_password_digest(@password) if @password.present?
  end

  # Verifies whether a password is right or not
  def valid_password?(password)
    compare(password)
  end

  def self.find_by_access_token(token)
    user = nil
    user_informations = JsonWebToken.decode(token)
    user_id = user_informations[:user_id]
    
    if user_id
      user = User.find(user_id)
    end
  end

  private

  # Method for generate a password hash
  def create_password_digest(password)
    ::BCrypt::Password.create(password, cost: PASSWORD_COST).to_s
  end

  # Method for compare password & password_digest
  def compare(password)
    return false if self.password_digest.blank?

    bcrypt = ::BCrypt::Password.new(self.password_digest)
    password = ::BCrypt::Engine.hash_secret(password, bcrypt.salt)

    password === self.password_digest
  end
end
