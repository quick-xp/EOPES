# == Schema Information
#
# Table name: estimates
#
#  id                  :integer          not null, primary key
#  type_id             :integer
#  user_id             :integer
#  sell_price          :decimal(20, 4)
#  sell_count          :integer
#  product_type_id     :integer
#  total_cost          :decimal(20, 4)
#  sell_total_price    :decimal(20, 4)
#  material_total_cost :decimal(20, 4)
#  profit              :decimal(20, 4)
#  total_volume        :decimal(20, 4)
#  created_at          :datetime
#  updated_at          :datetime
#

class Estimate < ActiveRecord::Base
  has_many :estimate_materials
  has_one :estimate_blueprint
  has_one :estimate_job_cost
end
