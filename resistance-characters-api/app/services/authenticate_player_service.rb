class AuthenticatePlayerService

  attr_reader :headers

  def initialize headers = {}
    @headers = headers
  end

  def player
    return if payload.blank?

    @player ||= Player.find(payload[:id])
  end

  private

  def authorization_header
    @authorization_header ||= headers['Authorization'] || ''
  end

  def token
    @token ||= authorization_header.split(' ').last
  end

  def payload
    return if token.blank?

    @payload ||= JWTService.decode(token)
  end

end
