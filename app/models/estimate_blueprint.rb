class EstimateBlueprint < ActiveRecord::Base
  belongs_to :estimate

  def get_product_type_id
    IndustryActivityProduct
    .where(:typeID => self.type_id, :activityID => 1)
    .first
    .productTypeID
  end
end
