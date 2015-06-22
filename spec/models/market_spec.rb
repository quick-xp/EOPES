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
    #マーケットデータは常に固定の値を返す
    get_dummy_market_data

    describe "MarketDataの取得" do
      context "Market データが存在しない時" do
        it "マーケットデータをCrestを使用して取得し保存する" do
          Market.refresh_market("10000002", "30000142", nil)
          expect(Market.where(:region_id => "10000002").count).to eq 1
          expect(MarketDetail.all.count).to be > 1
        end
      end

      context "マーケットデータ取得から一定時間が経過している場合" do
        it "データの入れ替えが行われる" do
          #時間を固定させる
          Timecop.travel(2014, 3, 31, 10, 0, 0)
          Market.refresh_market("10000002", "30000142", nil)
          #時間を一定時間進める
          after_time = Time.now + ENV['JITA_PRICE_REFRESH_TIME'].to_i.minutes + 1
          Timecop.travel(after_time)

          reset_market_data

          Market.refresh_market("10000002", "30000142", nil)

          expect(Market.where(:region_id => "10000002").count).to eq 1
          expect(MarketDetail.all.count).to eq 1

          Timecop.return
        end
      end

      context "マーケットデータ取得から一定時間が経過していない場合" do
        it "データの入れ替えが行われない" do
          #時間を固定させる
          Timecop.travel(2014, 3, 31, 10, 0, 0)
          Market.refresh_market("10000002", "30000142", nil)
          #時間を一定時間進める
          after_time = Time.now + ENV['JITA_PRICE_REFRESH_TIME'].to_i.minutes - 1
          Timecop.travel(after_time)
          reset_market_data

          Market.refresh_market("10000002", "30000142", nil)

          expect(Market.where(:region_id => "10000002").count).to eq 1
          expect(MarketDetail.all.count).to eq 2

          Timecop.return
        end
      end

    end

    describe "MarketDataの取得(並列処理)" do
      context "Market データが存在しない時" do
        it "マーケットデータをCrestを使用して取得し保存する" do
          Market.refresh_market_parallel("10000002", ["30000142", "30000143"], nil)
          expect(Market.where(:region_id => "10000002").count).to be > 1
          expect(MarketDetail.all.count).to be > 1
        end
      end

      context "マーケットデータ取得から一定時間が経過している場合" do
        it "データの入れ替えが行われる" do
          #時間を固定させる
          Timecop.travel(2014, 3, 31, 10, 0, 0)
          Market.refresh_market_parallel("10000002", ["30000142", "30000143"], nil)
          #時間を一定時間進める
          after_time = Time.now + ENV['JITA_PRICE_REFRESH_TIME'].to_i.minutes + 1
          Timecop.travel(after_time)

          reset_market_data

          Market.refresh_market_parallel("10000002", ["30000142", "30000143"], nil)

          expect(Market.where(:region_id => "10000002").count).to eq 2
          expect(MarketDetail.all.count).to eq 2

          Timecop.return
        end
      end

      context "マーケットデータ取得から一定時間が経過していない場合" do
        it "データの入れ替えが行われない" do
          #時間を固定させる
          Timecop.travel(2014, 3, 31, 10, 0, 0)
          Market.refresh_market_parallel("10000002", ["30000142", "30000143"], nil)
          #時間を一定時間進める
          after_time = Time.now + ENV['JITA_PRICE_REFRESH_TIME'].to_i.minutes - 1
          Timecop.travel(after_time)

          reset_market_data

          Market.refresh_market_parallel("10000002", ["30000142", "30000143"], nil)

          expect(Market.where(:region_id => "10000002").count).to eq 2
          expect(MarketDetail.all.count).to eq 4

          Timecop.return
        end
      end

    end
  end

  #再マーケット取得データ設定
  def reset_market_data
    crest_market_data = Hash::new()

    data1 = {
        "volume" => 10,
        "buy" => false,
        "price" => 5.9,
        "duration" => 90,
        "location" => {"location" => "60003760"},
        "issued" => "2015-03-26T23:26:44"
    }

    crest_market_data['totalCount_str'] = 1
    items = Array.new
    items << data1
    crest_market_data['items'] = items
    #stub
    #マーケットデータは常に固定の値を返す
    allow(Market).to receive(:get_market_data_from_crest).and_return(crest_market_data)
  end
end