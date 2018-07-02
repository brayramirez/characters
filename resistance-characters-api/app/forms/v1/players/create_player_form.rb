class V1::Players::CreatePlayerForm < V1::Players::PlayerForm

  LIMIT = 6

  property :code, readable: false

  def save
    self.code = generate_code

    super
  end

  private

  def generate_code
    code = SecureRandom.hex.first(LIMIT).upcase
    generate_code if Player.where(code: code).any?

    code
  end

end
