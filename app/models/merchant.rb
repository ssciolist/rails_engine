class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  validates_presence_of :name,
                        :created_at,
                        :updated_at


  default_scope {order(:id)}
  def self.random
    order('random()').limit(1).take
  end

  def self.single_revenue
    unscoped
    .joins(invoices: [:transactions, :invoice_items])
    .where(transactions: {result: 'success'})
    .select('merchants.id, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .group(:id).order('revenue DESC')
  end

  def self.most_items(group_size)
    unscoped
    .select('merchants.*, SUM(invoice_items.quantity) AS item_count')
    .joins(invoices: [:transactions, :invoice_items])
    .where(transactions: {result: 'success'})
    .group(:id)
    .order('item_count DESC')
    .limit(group_size)
  end

  def self.most_revenue(limit)
    joins(invoices: [:transactions, :invoice_items])
    .where(transactions: {result: 'success'})
    .group(:id)
    .order("sum(invoice_items.quantity * invoice_items.unit_price) DESC")
    .limit(limit)
  end

  def self.revenue_by_date(date)
    date = Date.parse(date)
    amount = joins(invoices: [:transactions, :invoice_items])
            .where(transactions: {result: 'success'}, invoices: {created_at: date.beginning_of_day..date.end_of_day})
            .sum("invoice_items.quantity * invoice_items.unit_price")
    {"total_revenue"=>"#{amount/100.00}"}
  end

  def self.favorite_merchant(customer_id)
    unscoped
    .select('COUNT(invoices.merchant_id) as merchant_count, merchants.name, merchants.id')
    .joins(invoices: :transactions)
    .where(transactions: {result: "success"}, invoices: {customer_id: customer_id})
    .group(:id)
    .order('merchant_count DESC')
    .limit(1)
    .first
  end

end
