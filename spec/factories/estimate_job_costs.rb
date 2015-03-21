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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :estimate_job_cost do
    region_id 1
    solar_system_id 1
    system_cost_index "9.99"
    base_job_cost "9.99"
    base_job_cost "9.99"
    job_fee "9.99"
    facility_cost "9.99"
    total_job_cost "9.99"
    estimate nil
  end
end
