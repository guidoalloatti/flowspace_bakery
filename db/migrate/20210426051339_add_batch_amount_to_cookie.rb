class AddBatchAmountToCookie < ActiveRecord::Migration[5.1]
  def change
    add_column :cookies, :batch_amount, :integer, null: false, default: 1
  end
end
