class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist #devise-jwt configuration

  validates :jti, presence: true

  def generate_jwt
    JWT.encode({ id: id,exp: 5.days.from_now.to_i }, Rails.env.devise.jwt.secret_key)
  end
end
