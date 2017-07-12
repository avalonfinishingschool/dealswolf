json.array!(@people) do |person|
  json.extract! person, :id, :name, :organization_id, :user_id, :team_id, :visibility_id
  json.url person_url(person, format: :json)
end
