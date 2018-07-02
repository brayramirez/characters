class Api::V1::SessionsController < Api::V1::BaseController

  def create
    @player = service.player
    @token = service.token
  end

  private

  def service
    @service ||= PlayerTokenService.new(params[:session][:code])
  end

end
