require 'rails_helper'

describe 'Item API business intelligence' do
  describe 'get /api/v1/items/most_items?quantity=#' do
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

  describe 'get /api/v1/items/:id/best_day' do
    it 'returns the date with the most sales for the given item using invoice date' do
      customer = create(:customer)
      merchant = create(:merchant)
      item = merchant.items.create!(attributes_for(:item))

      invoice = merchant.invoices.create!(attributes_for(:invoice, updated_at: Date.new(2001,2,3), merchant: merchant, customer_id: customer.id))
      invoice.transactions.create!(attributes_for(:transaction))
      invoice.invoice_items.create!(attributes_for(:invoice_item, item_id: item.id, quantity: 5))

      invoice2 = merchant.invoices.create!(attributes_for(:invoice, updated_at: Date.new(2011,2,3), merchant: merchant, customer_id: customer.id))
      invoice2.transactions.create!(attributes_for(:transaction))
      invoice2.invoice_items.create!(attributes_for(:invoice_item, item_id: item.id, quantity: 60))

      invoice3 = merchant.invoices.create!(attributes_for(:invoice, updated_at: Date.new(2015,2,3), merchant: merchant, customer_id: customer.id))
      invoice3.transactions.create!(attributes_for(:transaction))
      invoice3.invoice_items.create!(attributes_for(:invoice_item, item_id: item.id, quantity: 700))


      get "/api/v1/items/#{item.id}/best_day"

      best_day = JSON.parse(response.body)

      expect(response).to be_success
      expect(Date.parse(best_day['best_day'])).to eq(invoice3.updated_at)
    end
  end
end
