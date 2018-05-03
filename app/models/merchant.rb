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

  end

end
