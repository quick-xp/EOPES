class AddColumnToEstimates < ActiveRecord::Migration
  def change
    add_column :estimates, :production_time, :integer
  end
end
