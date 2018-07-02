class V1::Games::GameForm < BaseForm

  model :game

  property :name, validates: {presence: true}

end
