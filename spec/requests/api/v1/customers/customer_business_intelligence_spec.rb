require 'rails_helper'

describe 'Customer API business intelligence' do
  it 'returns customer favorite merchant' do
    customer = create(:customer)

    merchant = create(:merchant)
    item = merchant.items.create!(attributes_for(:item))
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice.transactions.create!(attributes_for(:transaction))
    invoice.invoice_items.create!(attributes_for(:invoice_item, item_id: item.id, quantity: 1, unit_price: 1200))

    merchant2 = create(:merchant)
    item2 = merchant2.items.create!(attributes_for(:item))
    invoice2 = create(:invoice, customer: customer, merchant: merchant2)
    invoice.transactions.create!(attributes_for(:transaction))
    invoice.invoice_items.create!(attributes_for(:invoice_item, item_id: item.id, quantity: 4, unit_price: 1200))

    get "/api/v1/customers/#{customer.id}/favorite_merchant"

    favorite_merchant = JSON.parse(response.body)

    expect(response).to be_success
  end
end
