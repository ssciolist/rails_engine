FactoryBot.define do
  factory :transaction do
    credit_card_number { rand(100000000..1000000000) }
    result "success"
    created_at { Faker::Date.between(22.days.ago, 44.days.ago) }
    updated_at { Faker::Date.between(10.days.ago, Date.today) }
    invoice 
  end

end
