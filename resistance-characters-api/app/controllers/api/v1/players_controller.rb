class Api::V1::PlayersController < Api::V1::BaseController

  before_action :authenticate_player, only: [:show, :update]
  before_action :authorize_updater, only: [:update]

  def show
    player
  end

  def create
    if create_form.validate(params[:player])
      create_form.save

      @player = create_form.model
    else
      render json: {
        error: create_form.errors
      },
      status: :unprocessable_entity
    end
  end

  def update
    if form.validate(params[:player])
      form.save

      @player = form.model
    else
      render json: {
        error: form.errors
      },
      status: :unprocessable_entity
    end
  end

  private

  def player
    @player ||= Player.find(params[:id])
  end

  def create_form
    @create_form ||=
      ::V1::Players::CreatePlayerForm.new(Player.new)
  end

  def form
    @form ||= ::V1::Players::PlayerForm.new(player)
  end

  def authorize_updater
    return if current_player&.id.to_i == params[:id].to_i

    render json: {error: 'Unauthorized'}, status: :unauthorized
  end

end
