json.array!(@estimates) do |estimate|
  json.extract! estimate, :id, :type_id, :user_id
  json.url estimate_url(estimate, format: :json)
end
