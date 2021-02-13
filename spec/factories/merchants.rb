FactoryBot.define do
  factory :book do
    name { Faker::Company.name }
  end
end