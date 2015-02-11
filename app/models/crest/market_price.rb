class MarketPrice < ActiveRecord::Base
  #Item の Universe 平均価格を取得する
  def self.get_universe_average_price(type_id)
    price = MarketPrice.where(:type_id => type_id).first
    if price.nil?
      price = 0.0
    else
      price.average_price
    end
  end
end
