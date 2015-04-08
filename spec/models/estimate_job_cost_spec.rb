# == Schema Information
#
# Table name: estimate_job_costs
#
#  id                :integer          not null, primary key
#  region_id         :integer
#  solar_system_id   :integer
#  system_cost_index :decimal(20, 16)
#  base_job_cost     :decimal(20, 4)
#  job_fee           :decimal(20, 4)
#  facility_cost     :decimal(20, 4)
#  total_job_cost    :decimal(20, 4)
#  estimate_id       :integer
#  created_at        :datetime
#  updated_at        :datetime
#

require 'rails_helper'

RSpec.describe EstimateJobCost, :type => :model do
  describe "System Cost Index の取得" do

    before :each do
      #The Forge : Jita
      FactoryGirl.create(:industry_system_jita, cost_index: 0.002, activity_id: 1)
      #The Forge : Itamo
      FactoryGirl.create(:industry_system, solar_system_id: 30000119, cost_index: 0.004, activity_id: 1)
      #The Forge : Jatate
      FactoryGirl.create(:industry_system, solar_system_id: 30000121, cost_index: 0.006, activity_id: 1)
      #Lonetrek : Nonni
      FactoryGirl.create(:industry_system, solar_system_id: 30001401, cost_index: 0.008, activity_id: 1)
    end

    context "Region Id と Solar System Id 両方指定されている かつ 存在するIDである場合" do
      it "SolarSystemのCost_Indexを返す" do
        expect(EstimateJobCost.get_system_cost_index(10000002, 30000142)).to eq 0.002
      end
    end

    context "Region Id が指定されているが Solar System Id が 指定されていない(nil) の場合" do
      it "Region内のCost_Indexの平均を返す" do
        # The Forge は 93 存在する
        expect(EstimateJobCost.get_system_cost_index(10000002, nil)).to eq 0.00012903225806451613
      end
    end

    context "Region Id と Solar System Id 両方指定されていない場合" do
      it "Universe全体のCost_Indexの平均を返す" do
        expect(EstimateJobCost.get_system_cost_index(nil, nil)).to eq 0.005
      end
    end

    context "Region Id が指定されているが 存在しない Region Id の場合" do
      it "0を返す" do
        expect(EstimateJobCost.get_system_cost_index(99999999, nil)).to eq 0
      end
    end

    context "Solar System Id が指定されているが 存在しない Solar System Id の場合" do
      it "0を返す" do
        expect(EstimateJobCost.get_system_cost_index(10000002, 9999999)).to eq 0
      end
    end
  end

  describe "Job Cost 再計算" do
    before :each do
      #The Forge : Jita
      FactoryGirl.create(:industry_system_jita, cost_index: 0.002, activity_id: 1)
      #The Forge : Itamo
      FactoryGirl.create(:industry_system, solar_system_id: 30000119, cost_index: 0.004, activity_id: 1)
      #The Forge : Jatate
      FactoryGirl.create(:industry_system, solar_system_id: 30000121, cost_index: 0.006, activity_id: 1)
      #Lonetrek : Nonni
      FactoryGirl.create(:industry_system, solar_system_id: 30001401, cost_index: 0.008, activity_id: 1)

      @material_list = []
      @material_list << build(:estimate_material,
                              type_id: 34,
                              require_count: 100,
                              base_quantity: 10,
                              adjusted_price: 3.9)
      @material_list << build(:estimate_material,
                              type_id: 35,
                              base_quantity: 20,
                              adjusted_price: 4.0)
      @material_list << build(:estimate_material,
                              type_id: 36,
                              base_quantity: 30,
                              adjusted_price: 4.1)

      @estimate_job_cost = EstimateJobCost.new
      # The Forge : Jita
      @estimate_job_cost.region_id = 10000002
      @estimate_job_cost.solar_system_id = 30000142
    end
    it "Base Job Cost は Σ(baseQuantity * adjustedPrice) * Runs" do
      @estimate_job_cost.re_calc_job_cost!(@material_list, 2)
      #(39 + 80 + 123) * 2
      expect(@estimate_job_cost.base_job_cost).to eq 484
    end
    it "JobFee は system_cost_index * baseJobCost" do
      @estimate_job_cost.re_calc_job_cost!(@material_list, 2)
      #0.002 * 484
      expect(@estimate_job_cost.job_fee).to eq 0.968
    end
    it "FacilityCost は JobFee * taxRate / 100" do
      @estimate_job_cost.re_calc_job_cost!(@material_list, 2)
      #0.968 * 10 / 100
      expect(@estimate_job_cost.facility_cost).to eq 0.0968
    end
    it "Total Job Cost は JobFee + FacilityCost" do
      @estimate_job_cost.re_calc_job_cost!(@material_list, 2)
      # 9.68 + 0.000968
      expect(@estimate_job_cost.total_job_cost).to eq 1.0648
    end
  end
end