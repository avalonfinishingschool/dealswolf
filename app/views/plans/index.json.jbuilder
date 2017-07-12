json.array!(@plans) do |plan|
  json.extract! plan, :id, :name, :number_users, :duration, :price
  json.url plan_url(plan, format: :json)
end
