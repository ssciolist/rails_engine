class ChangeCreatedAndUpdatedToBeTimestampInMerchants < ActiveRecord::Migration[5.1]
  def change
    change_column :merchants, :created_at, :timestamp
    change_column :merchants, :updated_at, :timestamp
  end
end
