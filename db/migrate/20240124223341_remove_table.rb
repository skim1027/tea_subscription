class RemoveTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :subscription_teas
    add_reference :teas, :subscription, null: false, foreign_key: true
  end
end
