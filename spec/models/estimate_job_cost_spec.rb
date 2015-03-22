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
  pending "add some examples to (or delete) #{__FILE__}"
end
