# == Schema Information
#
# Table name: estimates
#
#  id                  :integer          not null, primary key
#  type_id             :integer
#  user_id             :integer
#  sell_price          :decimal(20, 4)
#  sell_count          :integer
#  product_type_id     :integer
#  total_cost          :decimal(20, 4)
#  sell_total_price    :decimal(20, 4)
#  material_total_cost :decimal(20, 4)
#  profit              :decimal(20, 4)
#  total_volume        :decimal(20, 4)
#  created_at          :datetime
#  updated_at          :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :estimate do
    type_id 1
    user_id 1
    product_type_id 23783
    sell_price 10.0
    sell_count 2
    total_cost 20.0
    sell_total_price 20.0
    material_total_cost 5.0
    profit 5.0
    total_volume 100.0
  end
end
