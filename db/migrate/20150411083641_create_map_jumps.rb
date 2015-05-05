class CreateMapJumps < ActiveRecord::Migration
  def change
    create_table :map_jumps do |t|
      t.integer :from_solar_system_id
      t.integer :to_solar_system_id
      t.integer :jump
    end
  end
end
