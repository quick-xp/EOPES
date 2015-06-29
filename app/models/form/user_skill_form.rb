class UserSkillForm
  include ActiveModel::Model
  include ActiveModel::Naming

  def initialize(user_skills = nil)
    @errors = ActiveModel::Errors.new(self)

    if user_skills.present?
      self.skill_3380 = user_skills[:skill_3380]
      self.skill_3388 = user_skills[:skill_3388]
    end
  end

  def save(user_id)
    UserSkill.delete_all(:user_id => user_id)
    user_skill = UserSkill.new
    user_skill.skill_id = 3380
    user_skill.skill_level = self.skill_3380
    user_skill.user_id = user_id
    user_skill.save
    user_skill = UserSkill.new
    user_skill.skill_id = 3388
    user_skill.skill_level = self.skill_3388
    user_skill.user_id = user_id
    user_skill.save
  end

  def get_user_skill(user_id)
    @errors = ActiveModel::Errors.new(self)

    #UserSkill取得し、存在しない場合はDefault値を設定する
    user_skills = UserSkill.where(:user_id => user_id)
    self.skill_3380 = 5
    self.skill_3388 = 5
    user_skills.each do |s|
      if s.skill_id == 3380
        self.skill_3380 = s.skill_level.to_i
      end
      if s.skill_id == 3388
        self.skill_3388 = s.skill_level.to_i
      end
    end
    return self
  end

  attr_accessor :user_skill
  attr_accessor :skill_3380 #Industry
  attr_accessor :skill_3388 #Advanced Industry
  attr_reader :errors
end