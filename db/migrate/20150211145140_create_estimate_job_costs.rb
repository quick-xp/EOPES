class CreateEstimateJobCosts < ActiveRecord::Migration
  def change
    create_table :estimate_job_costs do |t|
      t.integer :region_id
      t.integer :solar_system_id
      t.decimal :system_cost_index, :precision => 20, :scale => 16
      t.decimal :base_job_cost, :precision => 20, :scale => 4
      t.decimal :job_fee, :precision => 20, :scale => 4
      t.decimal :facility_cost, :precision => 20, :scale => 4
      t.decimal :total_job_cost, :precision => 20, :scale => 4
      t.references :estimate, index: true

      t.timestamps
    end
  end
end
