json.array!(@deals) do |deal|
  json.extract! deal, :id, :contact_name, :company, :title, :value, :close_date, :start_date, :status, :phone, :visibility_id, :email, :user_id, :team_id, :stage_id
  json.url deal_url(deal, format: :json)
end
