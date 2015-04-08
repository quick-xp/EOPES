# == Schema Information
#
# Table name: market_prices
#
#  id             :integer          not null, primary key
#  type_id        :integer
#  adjusted_price :decimal(20, 4)
#  average_price  :decimal(20, 4)
#  created_at     :datetime
#  updated_at     :datetime
#

require 'rails_helper'

RSpec.describe MarketPrice, :type => :model do
  describe "ItemのUniverse平均価格取得" do
    before :each do
      create(:market_price)
    end
    context "ItemがUniverseに1件も存在しない場合" do
      it "0を平均価格とする" do
        expect(MarketPrice.get_universe_average_price(999)).to eq 0
      end
    end
    context "ItemがUniverseに存在する場合" do
      it "average_price項目を取得する" do
        expect(MarketPrice.get_universe_average_price(1)).to eq 9.99
      end
    end
  end
end
