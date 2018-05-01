FactoryBot.define do
  factory :item do
    name { Faker::Dune.character}
    description { Faker::Dune.quote}
    unit_price 12
    merchant_id 1
    created_at { Faker::Date.between(2.days.ago, 4.days.ago) }
    updated_at { Faker::Date.between(1.days.ago, Date.today) }
  end

end
