class AddIndexToMapJump < ActiveRecord::Migration
  def change
    add_index :map_jumps, [:from_solar_system_id, :to_solar_system_id]
  end
end
