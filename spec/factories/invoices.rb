FactoryBot.define do
  factory :invoice do
    status 'shipped'
    created_at "2018-04-30"
    updated_at "2018-04-30"
    merchant
    customer

    factory :invoice_with_transactions do
      transient do
        transactions_count 5
      end

      after(:create) do |invoice, evaluator|
        create_list(:transaction, evaluator.transactions_count, invoice: invoice)
      end
    end
  end
end
