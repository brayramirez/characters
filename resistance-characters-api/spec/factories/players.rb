FactoryBot.define do
  factory :player do
    code Faker::Crypto.md5.first(6).upcase
    name Faker::Name.first_name
  end
end
