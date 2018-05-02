FactoryBot.define do
  factory :invoice_item do
    quantity { rand(1..10) }
    unit_price { rand(100..1000) }
    created_at "2018-04-30"
    updated_at "2018-04-30"
    invoice
    item
  end
end
