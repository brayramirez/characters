class SelectedCharactersRulesService

  attr_reader :game

  def initialize game
    @game = game
  end

  def valid?
    selected_opposition <= number_of_opposition
  end

  def errors
    return [] if valid?

    ['Number of selected characters do not match number of players']
  end

  private

  def participants
    @participants ||= game.participants
  end

  def total_participants
    @total_participants ||= participants.count
  end

  def selected_opposition_count
    @selected_opposition_count ||= selected_opposition
  end

  def selected_opposition
    attributes =
      [:assassin?, :false_commander?, :blind_spy?, :deep_cover?]

    attributes.count { |attr| game.public_send(attr) } || 0
  end

  def number_of_opposition
    @character_distribution_service ||=
      CharacterDistributionService.new(game).number_of_opposition
  end

end
