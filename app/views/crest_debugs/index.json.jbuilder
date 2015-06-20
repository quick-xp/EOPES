json.array!(@crest_debugs) do |crest_debug|
  json.extract! crest_debug, :id
  json.url crest_debug_url(crest_debug, format: :json)
end
