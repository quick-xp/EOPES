class CreateMarkets < ActiveRecord::Migration
  def change
    create_table :markets do |t|
      t.integer :type_id
      t.integer :region_id

      t.timestamps
    end
  end
end
