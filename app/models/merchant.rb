class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  validates_presence_of :name,
                        :created_at,
                        :updated_at

  def self.random
    order('random()').limit(1).take
  end
end
