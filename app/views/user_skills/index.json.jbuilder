json.array!(@user_skills) do |user_skill|
  json.extract! user_skill, :id, :user_id, :skill_id, :skill_level
  json.url user_skill_url(user_skill, format: :json)
end
