class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  validates_presence_of :item_id,
                        :invoice_id,
                        :quantity,
                        :unit_price,
                        :created_at,
                        :updated_at

  default_scope { order(:id) }

  def self.random
    order('random()').limit(1).take
  end
end
