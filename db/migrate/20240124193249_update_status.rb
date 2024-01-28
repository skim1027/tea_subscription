class UpdateStatus < ActiveRecord::Migration[7.1]
  def change
    remove_column :subscriptions, :status
    add_column :subscriptions, :status, :integer
  end
end
