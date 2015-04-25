class MarketExplorerController < ApplicationController
  def index
    #location
    #region_list and solar_system_list
    @region_list = MapRegion.all.order(:regionName).map { |list| [list.regionName, list.regionID] }
    @solar_system_list = MapSolarSystem.where(:regionID => "10000002")
    .order(:solarSystemName)
    .map { |list| [list.solarSystemName, list.solarSystemID] }
  end

  #MarketGroup取得 取得
  def market_groups
    root_items = InvMarketGroup.all
    @items = []
    root_items.each do |item|
      v = Hash::new()
      v['id'] = item.marketGroupID
      v['parent'] = item.parentGroupID.nil? ? '#' : item.parentGroupID
      v['text'] = item.marketGroupName
      v['icon'] = false
      @items << v
    end

    #Item取得
    inv_types = InvType.where.not(:marketGroupID => nil)
    inv_types.each do |item|
      v = Hash::new()
      v['id'] = item.typeID + 100000 #idがかぶらないように100000足す
      v['parent'] = item.marketGroupID
      v['text'] = item.typeName
      v['icon'] = false
      v['url'] = "/"
      @items << v
    end
    render json: @items
  end

  #Market情報取得
  def get_market
    # select value setting
    @region_id = params[:region_id]
    @solar_system_id = params[:solar_system_id]
    @type_id = params[:type_id]
    #type_id は予め100000足していたので引く
    @type_id = @type_id.to_i - 100000
    @markets = Market.get_market_data(@region_id,
                                      @type_id,
                                      get_token)

    #Solar Systemでの絞込
    if @solar_system_id != ""
      market = Market.new
      market[:region_id] = @region_id
      market[:type_id] = @type_id
      station_ids = StaStation.where(:solarSystemID => @solar_system_id)
      @markets.market_details.each do |m|
        station_ids.each do |s|
          if s.stationID == m.station_id
            market.market_details << m
          end
        end
      end
      @markets = market
    end
  end

  #location設定
  def set_location
    # select value setting
    @region_id = params[:region_id]
    @solar_system_id = params[:solar_system_id]

    #region_list and solar_system_list
    @region_list = MapRegion.all.order(:regionName).map { |list| [list.regionName, list.regionID] }
    @solar_system_list = MapSolarSystem.where(:regionID => @region_id)
    .order(:solarSystemName)
    .map { |list| [list.solarSystemName, list.solarSystemID] }
  end
end