class Participant < ApplicationRecord

  enum character: [
    :commander,
    :bodyguard,
    :assassin,
    :false_commander,
    :deep_cover,
    :blind_spy
  ]

  belongs_to :player
  belongs_to :game

  scope :oppositions, -> { where(opposition: true) }

end
