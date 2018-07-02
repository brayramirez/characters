class V1::Players::PlayerForm < BaseForm

  model :player

  property :name, validates: {presence: true}

end
