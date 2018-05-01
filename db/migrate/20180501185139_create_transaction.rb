class CreateTransaction < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'citext'

    create_table :transactions do |t|
      t.references :invoice, foreign_key: true
      t.bigint :credit_card_number
      t.date :credit_card_expiration_date
      t.citext :result
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
