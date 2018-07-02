class PlayerTokenService

  attr_reader :code

  def initialize code
    @code = code
  end

  def player
    @player ||= Player.find_by!(code: code)
  end

  def token
    @token ||= JWTService.encode(payload)
  end

  private

  def payload
    {
      id: player.id,
      code: player.code,
      refresh_token: 1.day.from_now
    }
  end

end
