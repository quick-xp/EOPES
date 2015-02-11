class CreateEstimateBlueprints < ActiveRecord::Migration
  def change
    create_table :estimate_blueprints do |t|
      t.integer :type_id
      t.integer :me
      t.integer :te
      t.integer :runs
      t.references :estimate, index: true

      t.timestamps
    end
  end
end
