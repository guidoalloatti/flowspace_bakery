class AddBatchIdToCookies < ActiveRecord::Migration[5.1]
  def change
    add_reference :cookies, :batch, foreign_key: true
  end
end
