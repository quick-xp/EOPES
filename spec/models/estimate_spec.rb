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
  describe "削除依存関係テスト" do
    before :each do
      create(:estimate_material, :estimate_id => 1)
      create(:estimate_material, :estimate_id => 1)
      create(:estimate_material, :estimate_id => 2)
      create(:estimate_blueprint, :estimate_id => 1)
      create(:estimate_blueprint, :estimate_id => 2)
      create(:estimate_job_cost, :estimate_id => 1)
      create(:estimate_job_cost, :estimate_id => 2)

      @estimate = create(:estimate, :id => 1)
      @estimate.destroy
    end
    context "Estimate を削除した場合" do
      it "関連する estimate_material が削除される" do
        expect(EstimateMaterial.where(:estimate_id => 1).count).to eq 0
        expect(EstimateMaterial.where(:estimate_id => 2).count).to eq 1
      end
      it "関連する estimate_blueprint が削除される" do
        expect(EstimateBlueprint.where(:estimate_id => 1).count).to eq 0
        expect(EstimateBlueprint.where(:estimate_id => 2).count).to eq 1
      end
      it "関連する estimate_job_cost が削除される" do
        expect(EstimateBlueprint.where(:estimate_id => 1).count).to eq 0
        expect(EstimateBlueprint.where(:estimate_id => 2).count).to eq 1
      end
    end
  end
end
