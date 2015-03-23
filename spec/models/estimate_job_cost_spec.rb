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

    context "Region Id と Solar System Id 両方指定されている かつ 存在するIDである場合" do
      it "SolarSystemのCost_Indexを返す"
    end

    context "Region Id が指定されているが Solar System Id が 指定されていない(nil) の場合" do
      it "Region内のCost_Indexの平均を返す"
    end

    context "Region Id と Solar System Id 両方指定されていない場合" do
      it "Universe全体のCost_Indexの平均を返す"
    end

    context "Region Id が指定されているが 存在しない Region Id の場合" do
      it "0を返す"
    end

    context "Solar System Id が指定されているが 存在しない Solar System Id の場合" do
      it "0を返す"
    end
  end

  describe "Job Cost 再計算" do
      it "Base Job Cost は Σ(baseQuantity * adjustedPrice) * Runs"
      it "JobFee は system_cost_index * baseJobCost"
      it "FacilityCost は JobFee * taxRate / 100"
      it "Total Job Cost は JobFee + FacilityCost"
  end
end

