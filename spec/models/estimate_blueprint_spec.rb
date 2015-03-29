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
  describe "設計図ID からProduct ID 取得" do
    context "Antimatter Charge L Blueprint(1153) の場合" do
      it "Antimatter Charge L (238)" do
        @estimate_blueprint = EstimateBlueprint.new
        @estimate_blueprint.type_id = 1153
        expect(@estimate_blueprint.get_product_type_id).to eq 238
      end
    end
  end
end
