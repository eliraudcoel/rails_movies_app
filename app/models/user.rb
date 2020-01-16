class User < ApplicationRecord
  has_secure_password

  PASSWORD_COST = 10

  # Generates a hashed password based on the given value.
  # For legacy reasons, we use `encrypted_password` to store
  # the hashed password.
  def password=(new_password)
    @password = new_password
    self.encrypted_password = self.password_digest(@password) if @password.present?
  end

  # Verifies whether a password (ie from sign in) is the user password.
  def valid_password?(password)
    self.compare(password)
  end

  protected

  def password_digest(password)
    ::BCrypt::Password.create(password, cost: PASSWORD_COST).to_s
  end

  def compare(password)
    return false if self.encrypted_password.blank?

    bcrypt = ::BCrypt::Password.new(self.encrypted_password)
    password = ::BCrypt::Engine.hash_secret(password, bcrypt.salt)

    password === self.encrypted_password
  end
end
