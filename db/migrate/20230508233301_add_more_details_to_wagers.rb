class AddMoreDetailsToWagers < ActiveRecord::Migration[7.0]
  def change
    change_column :wagers, :wager_amount, :decimal, precision: 5, scale: 2
  end
end
