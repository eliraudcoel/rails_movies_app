class JsonWebToken
  class << self
    ALGORITHM = "HS256"
    SECRET_KEY = ENV["DEVISE_JWT_SECRET_KEY"]
    EXPIRED_TIME = 24.hours.from_now

    def encode(payload, exp = EXPIRED_TIME)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET_KEY, ALGORITHM)
    end

    def decode(token)
      body = JWT.decode(token, SECRET_KEY, true, { algorithm: ALGORITHM })
      HashWithIndifferentAccess.new body[0]
    rescue JWT::ExpiredSignature
      # TODO -> Token expired error
    end
  end
end
