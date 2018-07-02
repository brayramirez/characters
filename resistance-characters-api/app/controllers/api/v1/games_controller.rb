class Api::V1::GamesController < Api::V1::BaseController

  before_action :authenticate_player
  before_action :authorize_updater, only: [:update, :start, :end]

  def show
    game
  end

  def create
    create_form.host_id = current_player.id

    if create_form.validate(params[:game])
      create_form.save

      @game = create_form.model
    else
      render json: {
        error: create_form.errors
      },
      status: :unprocessable_entity
    end
  end

  def update
    if form.validate(params[:game])
      form.save

      @game = form.model
    else
      render json: {
        error: form.errors
      },
      status: :unprocessable_entity
    end
  end

  # TODO: Check current game status
  def start
    service = StartGameService.new(game)

    if service.valid?
      service.start_game
    else
      render json: {
        error: service.errors
      },
      status: :unprocessable_entity
    end
  end

  def end
    game.complete!
  end

  def join
    service = MaximumParticipantsRuleService.new(game)

    if service.slot_available?
      unless game.participants.where(player_id: current_player.id).any?
        game.participants.create(player_id: current_player.id)
      end
    else
      render json: {
        error: service.errors
      },
      status: :unprocessable_entity
    end
  end

  def disconnect
    participant = game.participants.find_by(player_id: current_player.id)
    participant.destroy if participant.present?

    head :ok
  end

  private

  def create_form
    @create_form ||=
      ::V1::Games::CreateGameForm.new(Game.new)
  end

  def form
    @form ||= ::V1::Games::UpdateGameForm.new(game)
  end

  def game
    @game ||= Game.find(params[:id])
  end

  def authorize_updater
    return if current_player.id == game.host_id

    render json: {error: 'Unauthorized'}, status: :unauthorized
  end

end
