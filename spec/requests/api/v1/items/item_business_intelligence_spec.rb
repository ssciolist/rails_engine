require 'rails_helper'

describe 'Item API business intelligence' do
  it 'returns the top x item instances ranked by total number sold' do
    customer = create(:customer)
    merchant = create(:merchant)
    item1 = merchant.items.create!(attributes_for(:item))
    item2 = merchant.items.create!(attributes_for(:item))
    item3 = merchant.items.create!(attributes_for(:item))
    invoice = merchant.invoices.create!(attributes_for(:invoice, merchant: merchant, customer_id: customer.id))
    invoice.transactions.create!(attributes_for(:transaction))
    invoice.invoice_items.create!(attributes_for(:invoice_item, item_id: item1.id, quantity: 5))
    invoice.invoice_items.create!(attributes_for(:invoice_item, item_id: item2.id, quantity: 3))
    invoice.invoice_items.create!(attributes_for(:invoice_item, item_id: item3.id, quantity: 15))

    get "/api/v1/items/most_items?quantity=2"

    top_items = JSON.parse(response.body)
    
    expect(response).to be_success
    expect(top_items.length).to eq(2)
    expect(top_items.first['description']).to eq(item3.description)
    expect(top_items.last['description']).to eq(item1.description)
  end
end
