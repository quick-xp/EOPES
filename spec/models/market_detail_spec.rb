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

require 'rails_helper'

RSpec.describe MarketDetail, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
