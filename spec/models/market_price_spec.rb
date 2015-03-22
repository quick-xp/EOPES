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

require 'rails_helper'

RSpec.describe MarketPrice, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
