json.array!(@organizations) do |organization|
  json.extract! organization, :id, :name, :address, :user_id, :team_id, :visibility_id
  json.url organization_url(organization, format: :json)
end
