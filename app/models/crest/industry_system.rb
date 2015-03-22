# == Schema Information
#
# Table name: industry_systems
#
#  id              :integer          not null, primary key
#  solar_system_id :integer
#  cost_index      :decimal(20, 16)
#  activity_id     :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class IndustrySystem < ActiveRecord::Base
end
