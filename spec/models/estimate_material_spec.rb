# == Schema Information
#
# Table name: estimate_materials
#
#  id                     :integer          not null, primary key
#  type_id                :integer
#  require_count          :integer
#  base_quantity          :integer
#  price                  :decimal(20, 4)
#  adjusted_price         :decimal(20, 4)
#  total_price            :decimal(20, 4)
#  jita_total_price       :decimal(20, 4)
#  jita_average_price     :decimal(20, 4)
#  universe_total_price   :decimal(20, 4)
#  universe_average_price :decimal(20, 4)
#  volume                 :decimal(20, 4)
#  total_volume           :decimal(20, 4)
#  estimate_id            :integer
#  created_at             :datetime
#  updated_at             :datetime
#

require 'rails_helper'

RSpec.describe EstimateMaterial, :type => :model do
  describe "必要原料数の計算" do

    context "NPC STATION の場合" do
      context "runs:2,base_quantity:101,ME:-10 の場合" do
        it "223 ( 2 * 101 * (1.0 * 1.1) (端数切り上げ))" do
          expect(EstimateMaterial.require_material(2, 101, -10, false)).to eq 223
        end
      end
      context "runs:2,base_quantity:101,ME:0 の場合" do
        it "202 ( 2 * 101 * (1.0 * 1.0) (端数切り上げ))" do
          expect(EstimateMaterial.require_material(2, 101, 0, false)).to eq 202
        end
      end
      context "runs:2,base_quantity:101,ME:10 の場合" do
        it "182 ( 2 * 101 * (1.0 * 0.9) (端数切り上げ))" do
          expect(EstimateMaterial.require_material(2, 101, 10, false)).to eq 182
        end
      end
    end

    context "POS STATION の場合" do
      context "runs:2,base_quantity:101,ME:-10 の場合" do
        it "218 ( 2 * 101 * (0.98 * 1.1) (端数切り上げ))" do
          expect(EstimateMaterial.require_material(2, 101, -10, true)).to eq 218
        end
      end
      context "runs:2,base_quantity:101,ME:0 の場合" do
        it "198 ( 2 * 101 * (0.98 * 1.0) (端数切り上げ))" do
          expect(EstimateMaterial.require_material(2, 101, 0, true)).to eq 198
        end
      end
      context "runs:2,base_quantity:101,ME:10 の場合" do
        it "179 ( 2 * 101 * (0.98 * 0.9) (端数切り上げ))" do
          expect(EstimateMaterial.require_material(2, 101, 10, true)).to eq 179
        end
      end
    end

  end

  describe "原料一覧の取得" do
    context "正常系" do
      before :each do
        #Market Price
        create(:market_price, :type_id => 34, :average_price => 1.11)
        create(:market_price, :type_id => 35)
        create(:market_price, :type_id => 36)
        create(:market_price, :type_id => 37)

        #Jita Price List
        @jita_price_list = Hash::new()
        @jita_price_list.store(34, 6.34)
        @jita_price_list.store(35, 6.35)
        @jita_price_list.store(36, 6.36)
        @jita_price_list.store(37, 6.37)
      end
      context "Antimatter Charge L Blueprint(1153) , blueprint_me:10 ,runs:2 の場合" do
        before :each do
          #stub
          #require_material は常に10.0を返す
          allow(EstimateMaterial).to receive(:require_material).and_return(10.0)
          #volume は常に5.0を返す
          allow(InvType).to receive(:get_type_volume).and_return(5.0)

          @material_list = EstimateMaterial.get_material_list(1153, 10, 0, 2, @jita_price_list)
        end
        it "原料は全部で4つ" do
          result = Array.new
          @material_list.each do |material|
            result << material.type_id
          end
          expect(result.size).to eq 4
        end
        it "原料に34,35,36,37が含まれる" do
          result = Array.new
          @material_list.each do |material|
            result << material.type_id
          end
          expect(result).to include 34, 35, 36, 37
        end
        it "base_quantity は type_id:34 が 1778" do
          material = @material_list.find { |r| r.type_id == 34 }
          expect(material.base_quantity).to eq 1778
        end
        it "type_id:34 require_count が設定される" do
          material = @material_list.find { |r| r.type_id == 34 }
          expect(material.require_count).to eq 10.0
        end
        it "jita 1原料あたりの平均価格が設定される" do
          material = @material_list.find { |r| r.type_id == 34 }
          expect(material.jita_average_price).to eq 6.34
        end
        it "jita 原料の合計価格が計算され設定される (1原料あたりの平均価格 * require_count)" do
          material = @material_list.find { |r| r.type_id == 34 }
          expect(material.jita_total_price).to eq 63.4
        end
        it "Universe 平均価格が設定される" do
          material = @material_list.find { |r| r.type_id == 34 }
          expect(material.universe_average_price).to eq 1.11
        end
        it "Universe 合計価格が計算され設定される (1原料あたりのUniverse平均価格 * require_count)" do
          material = @material_list.find { |r| r.type_id == 34 }
          expect(material.universe_total_price).to eq 11.1
        end
        it "Volume が設定される" do
          material = @material_list.find { |r| r.type_id == 34 }
          expect(material.volume).to eq 5.0
        end
        it "Total_Volumeが設定される (volume * require_count)" do
          material = @material_list.find { |r| r.type_id == 34 }
          expect(material.total_volume).to eq 50.0
        end
        it "price には Jita 平均価格が設定される" do
          material = @material_list.find { |r| r.type_id == 34 }
          expect(material.price).to eq 6.34
        end
        it "total_price には quantity * require_count が設定される" do
          material = @material_list.find { |r| r.type_id == 34 }
          expect(material.total_price).to eq (6.34 * 10.0)
        end
      end
    end
  end

end

