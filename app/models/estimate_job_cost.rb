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

class EstimateJobCost < ActiveRecord::Base
  belongs_to :estimate

  #region_id,solar_system_idどちらも指定されていない場合は全Cost_Indexの平均を
  #region_idのみ指定の場合は、Region内のCost_Indexの平均を
  #solar_system_idまで指定している場合はSolarSystemのCost_Indexを取得する
  def self.get_system_cost_index(region_id, solar_system_id)
    if region_id.nil?
      region_id = ""
    end
    if solar_system_id.nil?
      solar_system_id = ""
    end

    result = 0.0
    if region_id == "" && solar_system_id == ""
      result = IndustrySystem.where(:activity_id => 1).average(:cost_index)
    elsif solar_system_id == ""
      solar_systems = MapSolarSystem.where(:regionID => region_id)
      costs_sum = 0.0
      solar_systems.each do |s|
        v1 = IndustrySystem.where(:solar_system_id => s.solarSystemID).first
        if v1 != nil
          costs_sum += v1.cost_index.to_f
        end
      end
      if solar_systems.present?
        result = costs_sum / solar_systems.count
      end
    else
      v1 = IndustrySystem.where(:solar_system_id => solar_system_id, :activity_id => 1).first
      if v1 != nil
        result = v1.cost_index.to_f
      end
    end
    result
  end

  def re_calc_job_cost!(material_list, runs)
    #SystemCostIndex設定
    self.system_cost_index =
        EstimateJobCost.get_system_cost_index(self.region_id, self.solar_system_id)

    #BaseJobCost設定
    self.base_job_cost = get_base_job_cost(material_list, runs)

    #JobFee設定
    self.job_fee = get_job_fee

    #FacilityCost設定
    self.facility_cost = get_facility_cost

    #TotalJobInstallCost設定
    self.total_job_cost = get_total_job_cost
  end

  #BaseJobCost計算
  #Σ(baseQuantity * adjustedPrice)
  def get_base_job_cost(material_list, runs)
    base_job_cost = 0.0
    material_list.each do |material|
      base_job_cost += material.base_quantity * material.adjusted_price
    end
    base_job_cost * runs
  end

  #JobFee計算
  #system_cost_index * baseJobCost
  def get_job_fee
    self.system_cost_index * self.base_job_cost
  end

  #FacilityCost計算
  #JobFee * taxRate / 100
  def get_facility_cost
    self.job_fee * 10 / 100
  end

  #TotalJobCost計算
  #JobFee + FacilityCost
  def get_total_job_cost
    self.job_fee + self.facility_cost
  end

end
