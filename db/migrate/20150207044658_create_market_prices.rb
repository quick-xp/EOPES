class CreateMarketPrices < ActiveRecord::Migration
  def change
    create_table :market_prices do |t|
      t.integer :type_id
      t.decimal :adjusted_price, :precision => 20, :scale => 4
      t.decimal :average_price,:precision => 20, :scale => 4

      t.timestamps
    end
  end
end
