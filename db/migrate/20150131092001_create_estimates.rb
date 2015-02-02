class CreateEstimates < ActiveRecord::Migration
  def change
    create_table :estimates do |t|
      t.integer :type_id
      t.integer :user_id

      t.timestamps
    end
  end
end
