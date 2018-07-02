FactoryBot.define do
  factory :participant do
    player { create(:player) }
    game { create(:game) }
    opposition false
    character nil
  end
end
