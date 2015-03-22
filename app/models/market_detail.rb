# == Schema Information
#
# Table name: market_details
#
#  id         :integer          not null, primary key
#  volume     :integer
#  buy        :boolean
#  price      :decimal(10, )
#  duration   :integer
#  station_id :integer
#  issued     :datetime
#  market_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

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

  def self.get_market_data_order_by_price(type_id, region_id, limit)
    MarketDetail
    .includes(:market)
    .where(markets: {type_id: type_id, region_id: region_id})
    .order(:price)
    .limit(limit)
  end

  #Item の Region 平均価格を取得する
  #平均とは マーケットデータのTop 15 の価格の平均と定義する
  def self.get_region_average_price(region_id, type_id)
    market_details =
        MarketDetail.get_market_data_order_by_price(type_id,region_id,15)
    #average
    sum = 0.0
    market_details.each do |v|
      sum += v.price
    end
    (sum / market_details.size).round(2)
  end
end
