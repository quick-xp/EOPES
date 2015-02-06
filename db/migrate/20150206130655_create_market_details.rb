class CreateMarketDetails < ActiveRecord::Migration
  def change
    create_table :market_details do |t|
      t.integer :volume
      t.boolean :buy
      t.decimal :price
      t.integer :duration ,:precision => 20, :scale => 4
      t.integer :station_id
      t.datetime :issued
      t.references :market, index: true

      t.timestamps
    end
  end
end
