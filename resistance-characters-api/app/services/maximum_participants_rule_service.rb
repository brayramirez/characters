class MaximumParticipantsRuleService

  MAXIMUM_PARTICIPANTS = 10

  attr_reader :game

  def initialize game
    @game = game
  end

  def slot_available?
    game.participants.count < MAXIMUM_PARTICIPANTS
  end

  def maximum_participants_reached?
    !slot_available?
  end

  def errors
    ["Maximum number of players reached."]
  end

end
