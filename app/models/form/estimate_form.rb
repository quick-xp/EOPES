class EstimateForm
  include ActiveModel::Model

  attr_accessor :sell_price, :runs, :sell_count
  attr_accessor :blueprint_type_id, :blueprint_me, :blueprint_te
  attr_accessor :region_id, :solar_system_id
  attr_accessor :user_id

  def get_material_list
    material_list = Array.new
    #材料一覧取得
    materials = IndustryActivityMaterial.where(:typeID => self.blueprint_type_id, :activityID => 1)
    materials.each do |m|
      r = EstimateMaterial.new
      r.type_id = m.materialTypeID
      r.require_count = m.quantity
      r.total_price = m.quantity * 1.00 #TODO::price
      material_list << r
    end
    material_list
  end
end