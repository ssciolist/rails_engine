class Transaction < ApplicationRecord
  validates_presence_of :invoice_id,
                        :credit_card_number,
                        :result,
                        :created_at,
                        :updated_at
  belongs_to :invoice

  scope :successful, -> { where(result: 'success') }

  default_scope {order(:id)}
  def self.random
    order('random()').limit(1).take
  end
end
