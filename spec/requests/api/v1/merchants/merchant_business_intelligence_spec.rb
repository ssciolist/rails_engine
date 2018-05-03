require 'rails_helper'

describe 'Merchant API business intelligence' do
   it 'returns revenue for a specific merchant' do
    merchant = create(:merchant)
    item = merchant.items.create!(attributes_for(:item))
    customer = create(:customer)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice.transactions.create!(attributes_for(:transaction))
    invoice.invoice_items.create!(attributes_for(:invoice_item, item_id: item.id, quantity: 1, unit_price: 1200))

    get "/api/v1/merchants/#{merchant.id}/revenue"

    merchant_revenue = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant_revenue['revenue']).to eq('12.0')
  end

  it 'returns specified number of merchants with the most items' do
    merchant1 = create(:merchant, name: 'Best merchant')
    item = merchant1.items.create!(attributes_for(:item))
    merchant2 = create(:merchant, name: 'Second best')
    item2 = merchant2.items.create!(attributes_for(:item))
    merchant3 = create(:merchant, name: 'Bad merchant')
    item3 = merchant3.items.create!(attributes_for(:item))
    customer = create(:customer)
    invoice = create(:invoice_with_transactions, transactions_count: 1, customer: customer, merchant: merchant1)
    invoice.invoice_items.create!(attributes_for(:invoice_item, item_id: item.id, quantity: 3))
    invoice2 = create(:invoice_with_transactions, transactions_count: 1, customer: customer, merchant: merchant2)
    invoice2.invoice_items.create!(attributes_for(:invoice_item, item_id: item2.id, quantity: 2))
    invoice3 = create(:invoice_with_transactions, transactions_count: 1, customer: customer, merchant: merchant3)
    invoice.invoice_items.create!(attributes_for(:invoice_item, item_id: item3.id, quantity: 1))

    get '/api/v1/merchants/most_items?quantity=2'

    top_merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(top_merchants.count).to eq(2)
    expect(top_merchants.first['name']).to eq(merchant1.name)
    expect(top_merchants.last['name']).to eq(merchant2.name)
  end
end
