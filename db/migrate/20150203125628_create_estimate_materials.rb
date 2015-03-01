class CreateEstimateMaterials < ActiveRecord::Migration
  def change
    create_table :estimate_materials do |t|
      t.integer :type_id
      t.integer :require_count
      t.integer :base_quantity
      t.decimal :price, :precision => 20, :scale => 4
      t.decimal :adjusted_price, :precision => 20, :scale => 4
      t.decimal :total_price, :precision => 20, :scale => 4
      t.decimal :jita_total_price, :precision => 20, :scale => 4
      t.decimal :jita_average_price, :precision => 20, :scale => 4
      t.decimal :universe_total_price, :precision => 20, :scale => 4
      t.decimal :universe_average_price, :precision => 20, :scale => 4
      t.decimal :volume, :precision => 20, :scale => 4
      t.decimal :total_volume, :precision => 20, :scale => 4

      t.references :estimate, index: true
      t.timestamps
    end
  end
end
