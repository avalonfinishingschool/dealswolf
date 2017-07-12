json.array!(@currencies) do |currency|
  json.extract! currency, :id, :country, :extension
  json.url currency_url(currency, format: :json)
end
