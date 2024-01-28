class UpdateTables < ActiveRecord::Migration[7.1]
  def change
    remove_column :teas, :subscription_id
    add_reference :subscriptions, :tea, null: false, foreign_key: true
  end
end
