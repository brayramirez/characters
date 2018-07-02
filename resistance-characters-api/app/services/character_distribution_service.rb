class CharacterDistributionService

  DISTRIBUTION = {
    5 => 2,
    6 => 2,
    7 => 3,
    8 => 3,
    9 => 3,
    10 => 4
  }

  attr_reader :game

  def initialize game
    @game = game
  end

  def number_of_opposition
    @number_of_opposition ||= DISTRIBUTION[total_participants] || 0
  end

  private

  def participants
    @participants ||= game.participants
  end

  def total_participants
    @total_participants ||= participants.count
  end

end
