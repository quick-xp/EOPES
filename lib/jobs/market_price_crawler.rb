# rails runner "Jobs::MarketPriceCrawler.new.run"
require 'rest-client'
class Jobs::MarketPriceCrawler
  def run
    json = RestClient.get("https://crest-tq.eveonline.com/market/prices/")
    crest_markets = ActiveSupport::JSON.decode(json)
    crest_markets = crest_markets['items']
    markets_result = []
    crest_markets.each do |m|
      r = MarketPrice.new
      r.type_id = m['type']['id']
      r.adjusted_price = m['adjustedPrice']
      r.average_price = m['averagePrice']
      markets_result << r
    end
    MarketPrice.delete_all
    MarketPrice.import markets_result
  end
end
