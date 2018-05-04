class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  validates_presence_of :first_name,
                        :last_name,
                        :created_at,
                        :updated_at

  default_scope {order(:id)}

  def self.favorite_customer(merchant_id)
    unscoped
    .select('COUNT(invoices.customer_id) as customer_count, customers.*')
    .joins(invoices: :transactions)
    .where(transactions: {result: "success"}, invoices: {merchant_id: merchant_id})
    .group(:id)
    .order('customer_count DESC')
    .limit(1)
    .first
  end

  def self.random
    order('random()').limit(1).take
  end
end
