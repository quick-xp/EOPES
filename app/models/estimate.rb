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

class Estimate < ActiveRecord::Base
  has_many :estimate_materials, :dependent => :destroy
  has_one :estimate_blueprint, :dependent => :destroy
  has_one :estimate_job_cost, :dependent => :destroy

  #Production Time算出
  #base * timeModifier * skillModifier * runs
  #timeModifier = TEModifier and Facility Modifier (1.0 for NPC Station, 0.75 for many Pos assembly)
  #skillModifier = Industry:4% Advanced Industry:3%
  def calc_production_time(type_id, te, runs, user_id, pos_flag = false)
    base_time = IndustryActivity.where(:typeID => type_id, :activityID => 1).first.time
    if pos_flag then
      time_modifier = (0.75 - (te * 0.01))
    else
      time_modifier = (1.0 - (te * 0.01))
    end
    skill_modifier = get_production_skill_modifier(user_id)
    production_time = base_time * time_modifier * skill_modifier * runs
    return production_time.ceil
  end

  def get_production_skill_modifier(user_id)
    #UserSkill取得し、存在しない場合はDefault値を設定する
    user_skills = UserSkill.where(:user_id => user_id)
    skill_3380 = 5 #Industry
    skill_3388 = 5 #Advanced Industry
    user_skills.each do |s|
      if s.skill_id == 3380
        skill_3380 = s.skill_level.to_i
      end
      if s.skill_id == 3388
        skill_3388 = s.skill_level.to_i
      end
    end

    skill_modifier = (1 - (0.04 * skill_3380)) * (1- (0.03 * skill_3388))
    return skill_modifier
  end

end
