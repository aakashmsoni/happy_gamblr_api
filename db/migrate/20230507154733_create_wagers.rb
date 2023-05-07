class CreateWagers < ActiveRecord::Migration[7.0]
  def change
    create_table :wagers do |t|
      t.integer :user_id
      t.integer :bet_type_id
      t.integer :sport_id
      t.decimal :wager_amount
      t.integer :odds
      t.boolean :win
      t.decimal :profit_loss

      t.timestamps
    end
  end
end
