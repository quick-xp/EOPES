class CreateIndustrySystems < ActiveRecord::Migration
  def change
    create_table :industry_systems do |t|
      t.integer :solar_system_id
      t.decimal :cost_index, :precision => 20, :scale => 16
      t.integer :activity_id

      t.timestamps
    end
  end
end
