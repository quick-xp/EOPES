# == Schema Information
#
# Table name: market_details
#
#  id         :integer          not null, primary key
#  volume     :integer
#  buy        :boolean
#  price      :decimal(10, )
#  duration   :integer
#  station_id :integer
#  issued     :datetime
#  market_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :market_detail do
    volume 1
    buy false
    price "9.99"
    duration 1
    station_id 1
    issued "2015-02-06 22:06:55"
    market nil
  end
end
