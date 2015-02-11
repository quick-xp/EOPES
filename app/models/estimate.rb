class Estimate < ActiveRecord::Base
  has_many :estimate_materials
  has_one :estimate_blueprint
end
