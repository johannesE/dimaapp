json.array!(@possibilities) do |possibility|
  json.extract! possibility, :id, :name, :user_id, :topic_id
  json.url possibility_url(possibility, format: :json)
end
