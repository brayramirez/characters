class StartGameService

  attr_reader :game

  def initialize game
    @game = game
  end

  def start_game
    return unless valid?
    distribute_characters

    game.in_progress!
  end

  def valid?
    # Validate number of participants with selected characters
    minimum_participants_rule.minimum_participants_met? &&
      selected_characters_rule.valid?
  end

  def errors
    (minimum_participants_rule.errors + selected_characters_rule.errors).compact
  end

  private

  def minimum_participants_rule
    @minimum_participants_rule ||= MinimumParticipantsRuleService.new(game)
  end

  def selected_characters_rule
    @selected_characters_rule ||= SelectedCharactersRulesService.new(game)
  end

  def distribute_characters
    assign_oppositions
    assign_commander
    assign_bodyguard
  end

  def assign_oppositions
    oppositions.each_with_index do |opposition, index|
      opposition.update(
        opposition: true,
        character: opposition_characters[index]
      )
    end
  end

  def opposition_characters
    @opposition_characters ||= determine_opposition_characters
  end

  def determine_opposition_characters
    characters = []
    characters << :assassin if game.assassin?
    characters << :false_commander if game.false_commander?
    characters << :deep_cover if game.deep_cover?
    characters << :blind_spy if game.blind_spy?

    characters
  end

  def assign_commander
    return unless game.commander?

    commander = resistance.sample
    commander.update(character: :commander)
  end

  def assign_bodyguard
    return unless game.bodyguard?

    bodyguard = resistance.sample
    bodyguard.update(character: :bodyguard)
  end

  def resistance
    @resistance ||= participants - oppositions
  end

  def oppositions
    @oppositions ||= participants.sample(number_of_opposition)
  end

  def participants
    @participants ||= game.participants
  end

  def number_of_opposition
    @number_of_opposition ||=
      CharacterDistributionService.new(game).number_of_opposition
  end

end
