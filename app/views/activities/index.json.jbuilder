json.array!(@activities) do |activity|
  json.extract! activity, :id, :name, :deal_id, :team_id, :contact_id, :organization_id, :type_id, :note, :date, :time, :length, :user_id, :done
  json.url activity_url(activity, format: :json)
end
