json.array!(@cows) do |cow|
  json.extract! cow, :id, :name, :description
  json.url cow_url(cow, format: :json)
end