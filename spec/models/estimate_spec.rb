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

require 'rails_helper'

RSpec.describe Estimate, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
