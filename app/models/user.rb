class User < ApplicationRecord
  has_secure_password

  PASSWORD_COST = 10

  validates :email, presence: true
  validates :password_digest, presence: true

  # Generates & store in`password_digest` to store the hashed password.
  def password=(new_password)
    @password = new_password
    self.password_digest = create_password_digest(@password) if @password.present?
  end

  # Verifies whether a password is right or not
  def valid_password?(password)
    compare(password)
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
