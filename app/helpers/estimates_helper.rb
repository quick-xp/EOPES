module EstimatesHelper
  def get_region_name(region_id)
    region = MapRegion.where(:regionID => region_id).first
    if region.nil?
      "All Region"
    else
      region.regionName
    end
  end

  def get_solar_system_name(solar_system_id)
    solar_system = MapSolarSystem.where(:solarSystemID => solar_system_id).first
    if solar_system.nil?
      "All Solar System"
    else
      solar_system.solarSystemName
    end
  end
end
