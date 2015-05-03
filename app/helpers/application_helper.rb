module ApplicationHelper
  def active?(*controllers_name)
    return "active" if controllers_name.include?(params[:controller])
  end

  #FromからToまでのSolar System間のJump数を取得する
  def get_solar_system_jump_count(from_solar_system, to_station)
    p "------"
    p from_solar_system
    p to_station
    to_solar_system = StaStation.where(:stationID => to_station).first
    p to_solar_system
    jumps = MapJump.where(:from_solar_system_id => from_solar_system,
                  :to_solar_system_id => to_solar_system.solarSystemID).first
    if jumps.present?
      jumps.jump
    else
      999
    end
  end
end