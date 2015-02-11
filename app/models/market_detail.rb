class MarketDetail < ActiveRecord::Base
  belongs_to :market

  def get_station_name
    station_name = StaStation.where(:stationID => self.station_id).first
    if station_name.present?
      station_name.stationName
    else
      self.station_id
    end
  end
end
