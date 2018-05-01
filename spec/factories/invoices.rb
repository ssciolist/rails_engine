FactoryBot.define do
  factory :invoice do
    merchant_id 1
    customer_id 1
    status 'shipped'
    created_at "2018-04-30"
    updated_at "2018-04-30"
  end
end
