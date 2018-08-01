json.array!(@users) do |user|
  json.extract! user, :email, :password, :password_confirmation, :name, :last_name, :status_id, :role_id
  json.url user_url(user, format: :json)
end