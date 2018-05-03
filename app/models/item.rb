class Item < ApplicationRecord
  validates_presence_of :name,
                        :description,
                        :unit_price,
                        :merchant_id,
                        :created_at,
                        :updated_at
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  default_scope {order(:id)}

  def self.most_revenue(group_size)
    unscoped
    .joins(:invoice_items, invoices: :transactions)
    .where(transactions: {result: "success"})
    .group(:id)
    .order("sum(invoice_items.quantity * invoice_items.unit_price) DESC")
    .limit(group_size)
  end

  def self.most_items(group_size)
    unscoped
    .select('SUM(invoice_items.quantity) as item_count, items.*')
    .joins(invoices: :transactions)
    .where(transactions: {result: 'success'})
    .group(:id)
    .order('item_count DESC')
    .limit(group_size)
  end
end
