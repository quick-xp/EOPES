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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :industry_system do
    solar_system_id 1
    cost_index "9.99"
    activity_id 1
  end
end
