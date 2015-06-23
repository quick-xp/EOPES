# == Schema Information
#
# Table name: estimate_materials
#
#  id                     :integer          not null, primary key
#  type_id                :integer
#  require_count          :integer
#  base_quantity          :integer
#  price                  :decimal(20, 4)
#  adjusted_price         :decimal(20, 4)
#  total_price            :decimal(20, 4)
#  jita_total_price       :decimal(20, 4)
#  jita_average_price     :decimal(20, 4)
#  universe_total_price   :decimal(20, 4)
#  universe_average_price :decimal(20, 4)
#  volume                 :decimal(20, 4)
#  total_volume           :decimal(20, 4)
#  estimate_id            :integer
#  created_at             :datetime
#  updated_at             :datetime
#

class EstimateMaterial < ActiveRecord::Base
  belongs_to :estimate

  #material require = max(runs,ceil(round(runs * baseQuantity * materialModifier,2))
  #materialModifire = ME * FacilityModifier
  #FacilityModifire = NPC_STATION:1.0,POS:0.98
  def self.require_material(runs, base_quantity, me, pos_flag)
    facility_modifier = 1.0
    if pos_flag
      facility_modifier = 0.98
    end
    result = (runs * base_quantity * facility_modifier * (1.0 - me * 0.01)).ceil
    #計算の結果Runsのほうが大きい場合はRunsを必要量とする
    if result < runs
      runs
    else
      result
    end
  end

  def self.get_material_list(blueprint_type_id,blueprint_me,blueprint_te,blueprint_runs,jita_price_list)
    material_list = Array.new
    #材料一覧取得
    materials = IndustryActivityMaterial.where(:typeID => blueprint_type_id, :activityID => 1)
    materials.each do |m|
      r = EstimateMaterial.new
      r.type_id = m.materialTypeID
      r.base_quantity = m.quantity
      r.require_count = EstimateMaterial.require_material(blueprint_runs, m.quantity, blueprint_me, false)
      r.adjusted_price = MarketPrice.where(:type_id => r.type_id).first.adjusted_price
      r.jita_average_price = jita_price_list.fetch(m.materialTypeID)
      r.jita_total_price = r.jita_average_price * r.require_count
      r.universe_average_price = MarketPrice.where(:type_id => r.type_id).first.average_price
      #Universe に 1件も存在しない原料の場合は平均価格を0とする
      if r.universe_average_price.nil?
        r.universe_average_price = 0.0
      end
      r.universe_total_price = r.universe_average_price * r.require_count
      r.volume = InvType.get_type_volume(m.materialTypeID)
      r.total_volume = r.volume * r.require_count
      r.price = r.jita_average_price.round(2)
      r.total_price = r.require_count * r.price
      material_list << r
    end
    material_list
  end

end
