class CreateMerchants < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'citext'

    create_table :merchants do |t|
      t.citext :name
      t.date :created_at
      t.date :updated_at
    end
  end
end
