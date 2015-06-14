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
    factory :industry_system_jita do
        solar_system_id 30000142 #Jita
    end
    factory :industry_system_nonni do
      solar_system_id 30001401 #Nonni
      cost_index "0.003"
    end
    cost_index "0.002"
    activity_id 1 #Manufacturing
  end
end
