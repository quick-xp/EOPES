# == Schema Information
#
# Table name: estimate_blueprints
#
#  id          :integer          not null, primary key
#  type_id     :integer
#  me          :integer
#  te          :integer
#  runs        :integer
#  estimate_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class EstimateBlueprint < ActiveRecord::Base
  belongs_to :estimate

  def get_product_type_id
    IndustryActivityProduct
    .where(:typeID => self.type_id, :activityID => 1)
    .first
    .productTypeID
  end
end
