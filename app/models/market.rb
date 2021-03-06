# == Schema Information
#
# Table name: markets
#
#  id         :integer          not null, primary key
#  type_id    :integer
#  region_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Market < ActiveRecord::Base
  has_many :market_details, :dependent => :destroy

  #Market Data Refresh
  #一定時間以上経過している場合は、Crestからデータを取得、データ入れ替えを行う
  def self.refresh_market(region_id, type_id, access_token)
    market = Market.where(:region_id => region_id, :type_id => type_id).first
    if market.nil? ||
        market.updated_at < Time.now - ENV['JITA_PRICE_REFRESH_TIME'].to_i.minutes
      #Crest を用いてマーケットデータ取得
      crest_markets = Market.get_market_data_from_crest(region_id, type_id, access_token)
      crest_markets = crest_markets['items']
      #DB データ入れ替え
      Market.destroy_all(:region_id => region_id, :type_id => type_id)
      market = Market.new
      market[:region_id] = region_id
      market[:type_id] = type_id
      crest_markets.each do |crest_market|
        detail = MarketDetail.new
        detail.volume = crest_market['volume']
        detail.buy = crest_market['buy']
        detail.price = crest_market['price']
        detail.duration = crest_market['duration']
        detail.station_id = crest_market['location']['id']
        detail.issued = crest_market['issued'].to_datetime
        market.market_details << detail
      end
      market.save
    end
  end

  #get_market_data
  def self.get_market_data(region_id, type_id, access_token, market_kind="sell")
    #Crest を用いてマーケットデータ取得
    crest_markets = Market.get_market_data_from_crest(region_id, type_id, access_token, market_kind)
    crest_markets = crest_markets['items']

    market = Market.new
    market[:region_id] = region_id
    market[:type_id] = type_id
    crest_markets.each do |crest_market|
      detail = MarketDetail.new
      detail.volume = crest_market['volume']
      detail.buy = crest_market['buy']
      detail.price = crest_market['price']
      detail.duration = crest_market['duration']
      detail.station_id = crest_market['location']['id']
      detail.issued = crest_market['issued'].to_datetime
      market.market_details << detail
    end
    market
  end

  #Market Data Refresh(Parallel)
  #一定時間以上経過している場合は、Crestからデータを取得、データ入れ替えを行う
  def self.refresh_market_parallel(region_id, type_id_list, access_token)
    refresh_target_list = Array.new

    #Refresh 対象選定
    type_id_list.each do |type_id|
      market = Market.where(:region_id => region_id, :type_id => type_id).first
      if market.nil? ||
          market.updated_at < Time.now - ENV['JITA_PRICE_REFRESH_TIME'].to_i.minutes
        refresh_target_list << type_id
      end
    end

    #Refresh 対象のデータ取得
    threads = []
    crest_market_list = Array.new(refresh_target_list.size)
    refresh_target_list.each_with_index do |type_id, index|
      threads << Thread.new do
        #Crest を用いてマーケットデータ取得
        crest_market = Market.get_market_data_from_crest(region_id, type_id, access_token)
        crest_market_list[index] = crest_market['items']
      end
    end
    threads.each { |t| t.join }

    #DB データ入れ替え
    crest_market_list.each_with_index do |crest_markets, index|
      market = Market.new
      market[:region_id] = region_id
      market[:type_id] = refresh_target_list[index].to_i
      crest_markets.each do |crest_market|
        detail = MarketDetail.new
        detail.volume = crest_market['volume']
        detail.buy = crest_market['buy']
        detail.price = crest_market['price']
        detail.duration = crest_market['duration']
        detail.station_id = crest_market['location']['id']
        detail.issued = crest_market['issued']
        market.market_details << detail
      end
      Market.destroy_all(:region_id => region_id, :type_id => refresh_target_list[index])
      market.save
    end
  end

  def self.get_market_data_from_crest(region_id, type_id, access_token, market_kind = "sell")
    json = access_token.get("https://crest-tq.eveonline.com/market/" +
                                region_id.to_s +
                                "/orders/"+ market_kind.downcase + "/?type=https://crest-tq.eveonline.com/inventory/types/" +
                                type_id.to_s +
                                "/")
    ActiveSupport::JSON.decode(json.response.env.body)
  end
end

