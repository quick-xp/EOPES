class CreateEstimateMaterials < ActiveRecord::Migration
  def change
    create_table :estimate_materials do |t|
      t.integer :type_id
      t.integer :require_count
      t.decimal :price, :precision => 20, :scale => 4
      t.decimal :total_price, :precision => 20, :scale => 4
      t.decimal :jita_total_price, :precision => 20, :scale => 4
      t.decimal :jita_average_price, :precision => 20, :scale => 4
      t.decimal :universe_total_price, :precision => 20, :scale => 4
      t.decimal :universe_average_price, :precision => 20, :scale => 4

      t.timestamps
    end
  end
end
