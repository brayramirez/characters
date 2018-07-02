class Api::V1::BaseController < Api::BaseController

  attr_reader :current_player

  protected

  def authenticate_player
    @current_player = authenticate_player_service.player

    return if @current_player.present?

    render json: {error: 'Unauthorized'}, status: :unauthorized
  end

  def authenticate_player_service
    @authenticate_player_service ||=
      AuthenticatePlayerService.new(request.headers)
  end

end
