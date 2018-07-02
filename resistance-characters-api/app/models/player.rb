class Player < ApplicationRecord

  has_many :hosted_games,
    class_name: 'Game',
    foreign_key: :host_id,
    dependent: :destroy
  has_many :participants, dependent: :destroy

end
