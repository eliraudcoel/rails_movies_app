class JsonWebToken
  ALGORITHM = "HS256"
  SECRET_KEY = ENV["DEVISE_JWT_SECRET_KEY"]
  EXPIRED_TIME = 24.hours.from_now

  def self.encode(payload, exp = EXPIRED_TIME)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY, ALGORITHM)
  end

  def self.decode(token)
    body = JWT.decode(token, SECRET_KEY, true, { algorithm: ALGORITHM })
    byebug
    HashWithIndifferentAccess.new body[0]
    
    # rescue JWT::ExpiredSignature => error with invalid token
  end
end
