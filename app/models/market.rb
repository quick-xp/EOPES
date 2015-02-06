class Market < ActiveRecord::Base
  has_many :market_details ,:dependent => :destroy

  #Market Data Refresh
  #一定時間以上経過している場合は、Crestからデータを取得、データ入れ替えを行う
  def self.refresh_market(region_id, type_id, access_token)
    market = Market.where(:region_id => region_id, :type_id => type_id).first
    if market.nil? ||
        market.updated_at < Time.now - ENV['JITA_PRICE_REFRESH_TIME'].to_i.minutes
      #Crest を用いてマーケットデータ取得
      json = access_token.get("https://crest-tq.eveonline.com/market/" +
                                  region_id.to_s +
                                  "/orders/sell/?type=https://api-sisi.testeveonline.com/types/" +
                                  type_id.to_s +
                                  "/")
      crest_markets = ActiveSupport::JSON.decode(json.response.env.body)
      crest_markets = crest_markets['items']
      #DB データ入れ替え
      market = Market.delete_all(:region_id => region_id, :type_id => type_id)
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
        detail.issued = crest_market['issued']
        market.market_details << detail
      end
      market.save
    end
  end
end
