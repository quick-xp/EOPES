class Estimate < ActiveRecord::Base
  has_many :estimate_materials
  has_one :estimate_blueprint
  has_one :estimate_job_cost
end
