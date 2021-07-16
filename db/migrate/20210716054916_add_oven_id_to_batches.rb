class AddOvenIdToBatches < ActiveRecord::Migration[5.1]
  def change
    add_reference :batches, :oven, foreign_key: true
  end
end
