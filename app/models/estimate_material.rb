class EstimateMaterial < ActiveRecord::Base
  attr_accessor :base_quantity
  attr_accessor :adjusted_price
  attr_accessor :volume,:total_volume
  #material require = max(runs,ceil(round(runs * baseQuantity * materialModifier,2))
  #materialModifire = ME * FacilityModifier
  #FacilityModifire = NPC_STATION:1.0,POS:0.98
  def self.require_material(runs, base_quantity, me, pos_flag)
    facility_modifier = 1.0
    if pos_flag
      facility_modifier = 0.98
    end
    (runs * base_quantity * facility_modifier * (1.0 - me * 0.01)).ceil
  end
end
