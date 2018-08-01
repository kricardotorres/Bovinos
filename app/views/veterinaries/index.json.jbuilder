json.array!(@veterinaries) do |veterinary|
  json.extract! veterinary, :id, :name, :description
  json.url veterinary_url(veterinary, format: :json)
end