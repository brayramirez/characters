class Game < ApplicationRecord

  enum status: %i[waiting in_progress complete]

  belongs_to :host, class_name: 'Player'
  has_many :participants, dependent: :destroy

  #
  # When commander is selected, assassin is automatically selected
  #
  def assassin?
    commander?
  end

end
