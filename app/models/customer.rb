class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  validates_presence_of :first_name,
                        :last_name,
                        :created_at,
                        :updated_at

  def self.favorite_customer(merchant_id)
    favorite = joins(invoices: :transactions)
                .where(transactions: {result: "success"}, invoices: {merchant_id: merchant_id})
                .order('count_id desc')
                .group(:id)
                .count(:id)
                .first
    find(favorite[0])
  end

  def self.random
    order('random()').limit(1).take
  end
end
