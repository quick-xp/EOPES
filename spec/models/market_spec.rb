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

require 'rails_helper'
require 'json'

RSpec.describe Market, :type => :model do
  describe "マーケットデータ取得" do
    before :each do
      crest_market_data = Hash::new()

      data1 = {
          "volume" => 10,
          "buy" => false,
          "price" => 5.9,
          "duration" => 90,
          "location" => {"location" => "60003760"},
          "issued" => "2015-03-26T23:26:44"
      }
      data2 = {
          "volume" => 10,
          "buy" => false,
          "price" => 5.91,
          "duration" => 90,
          "location" => {"location" => "60003760"},
          "issued" => "2015-03-26T23:26:44"
      }

      crest_market_data['totalCount_str'] = 2
      items = Array.new
      items << data1
      items << data2
      crest_market_data['items'] = items
      #stub
      #マーケットデータは常に固定の値を返す
      allow(Market).to receive(:get_market_data_from_crest).and_return(crest_market_data)
    end
    describe "MarketDataの取得" do
      context "Market データが存在しない時" do
        it "マーケットデータをCrestを使用して取得し保存する" do
          Market.refresh_market("10000002", "30000142", nil)
          expect(Market.where(:region_id => "10000002").count).to eq 1
          expect(MarketDetail.all.count).to be > 1
        end
      end
    end

    describe "MarketDataの取得(並列処理)" do
      context "Market データが存在しない時" do
        it "マーケットデータをCrestを使用して取得し保存する" do
          Market.refresh_market_parallel("10000002", ["30000142","30000143"], nil)
          expect(Market.where(:region_id => "10000002").count).to be > 1
          expect(MarketDetail.all.count).to be > 1
        end
      end
    end
  end
end
