class CreateEstimates < ActiveRecord::Migration
  def change
    create_table :estimates do |t|
      t.integer :type_id
      t.integer :user_id
      t.decimal :sell_price, :precision => 20, :scale => 4
      t.integer :sell_count
      t.integer :product_type_id
      t.decimal :total_cost, :precision => 20, :scale => 4
      t.decimal :sell_total_price, :precision => 20, :scale => 4
      t.decimal :material_total_cost, :precision => 20, :scale => 4
      t.decimal :profit, :precision => 20, :scale => 4
      t.decimal :total_volume, :precision => 20, :scale => 4

      t.timestamps
    end
  end
end
