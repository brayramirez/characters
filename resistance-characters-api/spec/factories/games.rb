FactoryBot.define do
  factory :game do
    code Faker::Crypto.md5.first(6).upcase
    name Faker::Name.first_name
    status :waiting
    commander false
    false_commander false
    bodyguard false
    blind_spy false
    deep_cover false
    host { create(:player) }
  end
end
