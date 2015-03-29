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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :estimate_material do
    sequence(:type_id) { |n| "#{n}"}
    require_count 1
    price "9.99"
    total_price "9.99"
    jita_total_price "9.99"
    jita_average_price "9.99"
    universe_total_price "9.99"
    universe_average_price "9.99"
  end
end
