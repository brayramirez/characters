class MinimumParticipantsRuleService

  MINIMUM_PARTICIPANTS = 5

  attr_reader :game

  def initialize game
    @game = game
  end

  def minimum_participants_met?
    game.participants.count >= MINIMUM_PARTICIPANTS
  end

  def errors
    return [] if minimum_participants_met?

    ["#{MINIMUM_PARTICIPANTS} players required to start game."]
  end

end
