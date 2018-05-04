require 'rails_helper'

describe 'Merchant API business intelligence' do
  describe 'get /api/v1/merchants/#{merchant.id}/revenue' do
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
  end

  describe 'get /api/v1/merchants/most_items?quantity=#' do
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

  describe 'get /merchants/:id/revenue?date=x' do
    it 'returns the total revenue for a specific invoice date' do
      customer = create(:customer)
      merchant = create(:merchant)
      item = merchant.items.create!(attributes_for(:item))

      invoice = create(:invoice, updated_at: Date.new(2011, 2, 3), customer: customer, merchant: merchant)
      invoice.transactions.create!(attributes_for(:transaction))
      invoice.invoice_items.create!(attributes_for(:invoice_item, item_id: item.id, quantity: 1, unit_price: 1200))

      invoice2 = create(:invoice, updated_at: Date.new(2011, 4, 6), customer: customer, merchant: merchant)
      invoice2.transactions.create!(attributes_for(:transaction))
      invoice2.invoice_items.create!(attributes_for(:invoice_item, item_id: item.id, quantity: 1, unit_price: 1600))

      get "/api/v1/merchants/#{merchant.id}/revenue?date=#{invoice2.updated_at}"

      merchant_revenue = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant_revenue['revenue']).to eq('16.0')
    end
  end

  describe 'GET /api/v1/merchants/:id/favorite_customer' do
    it 'returns the customer witht he most transactions' do
      customer = create(:customer)
      customer2 = create(:customer)
      merchant = create(:merchant)
      item = merchant.items.create!(attributes_for(:item))

      invoice = create(:invoice, updated_at: Date.new(2011, 2, 3), customer: customer, merchant: merchant)
      invoice.transactions.create!(attributes_for(:transaction))
      invoice.invoice_items.create!(attributes_for(:invoice_item, item_id: item.id, quantity: 1, unit_price: 1200))

      invoice2 = create(:invoice, updated_at: Date.new(2011, 4, 6), customer: customer, merchant: merchant)
      invoice2.transactions.create!(attributes_for(:transaction))
      invoice2.invoice_items.create!(attributes_for(:invoice_item, item_id: item.id, quantity: 1, unit_price: 1600))

      invoice3 = create(:invoice, updated_at: Date.new(2011, 4, 6), customer: customer2, merchant: merchant)
      invoice3.transactions.create!(attributes_for(:transaction))
      invoice3.invoice_items.create!(attributes_for(:invoice_item, item_id: item.id, quantity: 1, unit_price: 4000))

      get "/api/v1/merchants/#{merchant.id}/favorite_customer"

      fav = JSON.parse(response.body)

      expect(response).to be_success
      expect(fav['id']).to eq(customer.id)
    end
  end

  describe 'get /merchants/:id/revenue?date=x' do
    it 'returns the total revenue for a specific invoice date' do
      customer = create(:customer)
      merchant = create(:merchant)
      item = merchant.items.create!(attributes_for(:item))

      invoice = create(:invoice, updated_at: Date.new(2011, 2, 3), customer: customer, merchant: merchant)
      invoice.transactions.create!(attributes_for(:transaction))
      invoice.invoice_items.create!(attributes_for(:invoice_item, item_id: item.id, quantity: 1, unit_price: 1200))

      invoice2 = create(:invoice, updated_at: Date.new(2011, 4, 6), customer: customer, merchant: merchant)
      invoice2.transactions.create!(attributes_for(:transaction))
      invoice2.invoice_items.create!(attributes_for(:invoice_item, item_id: item.id, quantity: 1, unit_price: 1600))

      get "/api/v1/merchants/#{merchant.id}/revenue?date=#{invoice2.updated_at}"

      merchant_revenue = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant_revenue['revenue']).to eq('16.0')
    end
  end

  describe 'GET /api/v1/merchants/most_revenue?quantity=x' do
    it 'returns the most revenue for an amount of merchants' do
      customer = create(:customer)
      merchant = create(:merchant)
      merchant2 = create(:merchant)
      item = merchant.items.create!(attributes_for(:item))

      invoice = create(:invoice, updated_at: Date.new(2011, 2, 3), customer: customer, merchant: merchant)
      invoice.transactions.create!(attributes_for(:transaction))
      invoice.invoice_items.create!(attributes_for(:invoice_item, item_id: item.id, quantity: 1, unit_price: 1200))

      invoice2 = create(:invoice, updated_at: Date.new(2011, 4, 6), customer: customer, merchant: merchant2)
      invoice2.transactions.create!(attributes_for(:transaction))
      invoice2.invoice_items.create!(attributes_for(:invoice_item, item_id: item.id, quantity: 1, unit_price: 1600))

      get "/api/v1/merchants/most_revenue?quantity=1"

      high_merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(high_merchant.first['id']).to eq(merchant2.id)
    end
  end

  describe 'GET /api/v1/merchants/revenue?date=x' do
    it 'returns the revenue on a particular date' do
      customer = create(:customer)
      merchant = create(:merchant)
      merchant2 = create(:merchant)
      item = merchant.items.create!(attributes_for(:item))

      invoice = create(:invoice, created_at: Date.new(2011, 2, 3), customer: customer, merchant: merchant)
      invoice.transactions.create!(attributes_for(:transaction))
      invoice.invoice_items.create!(attributes_for(:invoice_item, item_id: item.id, quantity: 1, unit_price: 1200))

      invoice2 = create(:invoice, created_at: Date.new(2011, 2, 3), customer: customer, merchant: merchant2)
      invoice2.transactions.create!(attributes_for(:transaction))
      invoice2.invoice_items.create!(attributes_for(:invoice_item, item_id: item.id, quantity: 1, unit_price: 1600))

      get "/api/v1/merchants/revenue?date=2011-02-03"

      revenue = JSON.parse(response.body)
      
      expect(response).to be_success
      expect(revenue['total_revenue']).to eq('28.0')
    end
  end
end
