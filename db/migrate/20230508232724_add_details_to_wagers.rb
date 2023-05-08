class AddDetailsToWagers < ActiveRecord::Migration[7.0]
  def change
    change_column :wagers, :profit_loss, :decimal, precision: 5, scale: 2
  end
end
