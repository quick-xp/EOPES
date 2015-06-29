require 'ruby-duration'

module ApplicationHelper
  def active?(*controllers_name)
    return "active" if controllers_name.include?(params[:controller])
  end

  def active_market_explorer?(*controllers_name, kind)
    return "active" if controllers_name.include?(params[:controller]) &&
        (kind == params[:market_kind])
  end

  #FromからToまでのSolar System間のJump数を取得する
  def get_solar_system_jump_count(from_solar_system, to_station)
    to_solar_system = StaStation.where(:stationID => to_station).first
    jumps = MapJump.where(:from_solar_system_id => from_solar_system,
                          :to_solar_system_id => to_solar_system.solarSystemID).first
    if jumps.present?
      jumps.jump
    else
      999
    end
  end

  def second_to_time(second)
    if second.nil?
      second = 0
    end
    d = Duration.new(second)
    return d.format("%dd %Hh %Mm %Ss")
  end
end