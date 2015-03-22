# == Schema Information
#
# Table name: estimate_blueprints
#
#  id          :integer          not null, primary key
#  type_id     :integer
#  me          :integer
#  te          :integer
#  runs        :integer
#  estimate_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe EstimateBlueprint, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
