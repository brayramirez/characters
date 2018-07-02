class JWTService

  def self.encode payload, expiration = 24.hours.from_now
    payload[:expiration] = expiration.to_i

    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end

  def self.decode token
    body = JWT.decode(token, Rails.application.credentials.secret_key_base)[0]
    body.deep_symbolize_keys!
  end

end
