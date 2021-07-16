class CreateBatch < ActiveRecord::Migration[5.1]
  def change
    create_table :batches do |t|
      t.string :filling
      t.integer :size
      t.string :status 

      t.timestamps
    end
  end
end
