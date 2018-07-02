class V1::Games::CreateGameForm < V1::Games::GameForm

  LIMIT = 6

  property :code, readable: false
  property :host_id, readable: false

  def save
    self.code = generate_code

    super

    join_player
  end

  private

  def generate_code
    code = SecureRandom.hex.first(LIMIT).upcase
    generate_code if Game.where(code: code).any?

    code
  end

  def join_player
    Participant.create(game_id: model.id, player_id: model.host_id)
  end

end
