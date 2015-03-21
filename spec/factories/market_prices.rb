# == Schema Information
#
# Table name: market_prices
#
#  id             :integer          not null, primary key
#  type_id        :integer
#  adjusted_price :decimal(20, 4)
#  average_price  :decimal(20, 4)
#  created_at     :datetime
#  updated_at     :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :market_price do
    type_id 1
    adjusted_price "9.99"
    average_price "9.99"
  end
end
